var express = require('express');
var router = express.Router();

const mysql2 = require('mysql2');
const mysql = mysql2.createPool({
  host: 'localhost',
  user : 'root',
  password : '',
  database : 'db_stock'
});


/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { title: 'Express' });
});

router.get('/product',(req, res) => {
  mysql.query('SELECT * FROM tbl_product',(err, rs) => {
    if (err) {
      res.send(err);
    } else {
      res.render('product', { data: {}, products: rs });
    }
  })
    
})

router.post('/product', (req, res) => {
  mysql.query('INSERT INTO tbl_product SET ?', req.body,(err, rs) => {
      if (err) {
        res.send(err);
      } else {
        res.redirect('product');
      }
  })
})


router.get('/productDelete/:id', (req, res) => {
  var condition = [req.params.id];
  mysql.query('DELETE FROM tbl_product WHERE id = ?', condition, (err, rs) => {
    if(err) {
      res.send(err)
    } else {
      res.redirect('/product');
    }
  })
})

router.get('/productEdit/:id', (req, res) => {
    var condition = [req.params.id];
    var sql = 'SELECT * FROM tbl_product WHERE id = ?'

    mysql.query(sql, condition, (err, rs) => {
      if(err) {
        res.send(err)
      } else {
        sql = 'SELECT * FROM tbl_product';
        mysql.query(sql, (err, products) => {
            if(err) {
              res.send(err)
            } else {
              res.render('product', { data: rs[0], products: products });
            }
        })
        
      }
    })
})

router.post('/productEdit/:id', (req, res) => {
   var params = [req.body.barcode, req.body.name, req.params.id ]
   var sql = 'UPDATE tbl_product SET barcode = ?, name = ? WHERE id = ?';

   mysql.query(sql, params, (err, rs) => {
      if(err) {
        res.send(err);
      } else {
        res.redirect('/product');
      }
   })
})

router.get('/importStock', function(req, res) {
  res.render('importStock');
});

router.post('/importStock', (req, res) => {
  var sql = 'INSERT INTO tbl_import_stock(product_id, qty, import_date) VALUES (?, ?, now())';
  var params = [req.body.product_id, req.body.qty];
  mysql.query(sql, params, (err, rs) => {
    if(err) {
      res.send(err);
    } else {
      res.redirect('importStockSuccess');
    }
  })
})

router.get('/importStockSuccess', (req, res) => {
  res.render('importStockSuccess');
})

router.post('/searchProduct', (req, res) =>  {
    var sql = 'SELECT * FROM tbl_product WHERE barcode = ?'
    mysql.query(sql, req.body.barcode, (err,rs) => {
      if(err) {
        res.send(err);
      } else {
        res.json(rs);
      }
    })
});

router.get('/outStock', function(req, res) {
  res.render('outStock');
});

router.post('/outStock', (req, res) => {
  var sql = 'INSERT INTO tbl_outstock(product_id, qty, outdate) VALUES (?, ?, now())';
  var params = [req.body.product_id, req.body.qty];
  mysql.query(sql, params, (err, rs) => {
    if(err) {
      res.send(err);
    } else {
      res.redirect('outStockSuccess');
    }
  })
})

router.get('/outStockSuccess', (req, res) => {
  res.render('outStockSuccess');
})

router.get('/report', (req, res) => {
  var data = { from: '', to: '' , products: [] };
  res.render('reportStock', data);
})

router.post('/report',(req,res) => {
  var from = req.body.from + '00:00';
  from = from.replace('/','-');

  var to = req.body.to + '23:59';
  to = to.replace('/', '-');

  var sql = `
        SELECT
            tbl_product.barcode,
            tbl_product.name,
                (
                  SELECT SUM(qty) FROM tbl_import_stock
                  WHERE (import_date BETWEEN ? AND ? )
                  AND product_id = tbl_product.id
                ) AS total_import,

                (
                  SELECT SUM(qty) FROM tbl_outstock
                  WHERE (outdate BETWEEN ? AND ? )
                  AND product_id = tbl_product.id
                ) AS total_out                 
        From tbl_product
      `;

    var params = [from, to, from, to ];

    mysql.query(sql, params, (err, rs) => {
         if (err) {
          res.send(err);
        } else {
          var data = { from: req.body.from, to: req.body.to, products: rs };
          res.render('reportStock', data);
        }
    })
  
})

module.exports = router;
