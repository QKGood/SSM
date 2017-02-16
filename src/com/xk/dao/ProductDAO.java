package com.xk.dao;

import com.xk.bean.Product;
import com.xk.common.bean.Pager4EasyUI;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by xiao-kang on 2017/2/15.
 */
@Repository
public interface ProductDAO extends BaseDAO<Product> {
    public List<Product> queryByPagerAndCriteria(@Param("pager")Pager4EasyUI<Product> pager, @Param("product")Product product);
}
