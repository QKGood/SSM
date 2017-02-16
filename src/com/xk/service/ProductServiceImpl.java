package com.xk.service;

import com.xk.bean.Product;
import com.xk.common.bean.Pager4EasyUI;
import com.xk.dao.ProductDAO;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.io.Serializable;
import java.util.List;

/**
 * Created by xiao-kang on 2017/2/15.
 */
@Service
public class ProductServiceImpl implements ProductService {

    @Resource
    private ProductDAO productDAO;
    @Override
    public List<Product> queryAll() {
        return productDAO.queryAll();
    }

    @Override
    public Product queryById(Serializable id) {
        return productDAO.queryById(id);
    }

    @Override
    public void add(Product product) {
        productDAO.add(product);
    }

    @Override
    public void update(Product product) {
        productDAO.update(product);
    }

    @Override
    public void deleteById(Serializable id) {
        productDAO.deleteById(id);
    }

    @Override
    public Pager4EasyUI<Product> queryByPagerAndCriteria(Pager4EasyUI<Product> pager, Product product) {
        List<Product> products = productDAO.queryByPagerAndCriteria(pager,product);
        pager.setRows(products);
        pager.setTotal(productDAO.countByCriteria(product));
        return pager;
    }
}
