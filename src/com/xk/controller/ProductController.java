package com.xk.controller;


import com.xk.bean.Product;
import com.xk.common.bean.ControllerResult;
import com.xk.common.bean.Pager4EasyUI;
import com.xk.service.ProductService;
import org.apache.ibatis.annotations.Param;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import ch.qos.logback.classic.Logger;
import javax.annotation.Resource;
import java.util.List;

/**
 * Created by xiao-kang on 2017/2/15.
 */
@Controller
@RequestMapping("/product")
public class ProductController {

    private Logger logger = (Logger) LoggerFactory.getLogger(ProductController.class);

    @Resource
    private ProductService productService;

    @RequestMapping(value="product_page",method = RequestMethod.GET)
    public String showProduct(){
        return "product";
    }

    @ResponseBody
    @RequestMapping(value="query_pager",method=RequestMethod.GET)
    public Pager4EasyUI<Product> queryPager(@Param("page")String page, @Param("rows")String rows){
        logger.info("分页查询所有产品");
        Pager4EasyUI<Product> pager = new Pager4EasyUI<Product>();
        pager.setPageNo(Integer.valueOf(page));
        pager.setPageSize(Integer.valueOf(rows));
        Product product = new Product();
        //product.setName("2");
        pager = productService.queryByPagerAndCriteria(pager,product);
        return pager;
    }

    @ResponseBody
    @RequestMapping(value="add", method=RequestMethod.POST)
    public ControllerResult productAdd(Product product){
        logger.info("添加产品");
        productService.add(product);
        return ControllerResult.getSuccessResult("添加成功");
    }

    @ResponseBody
    @RequestMapping(value="update", method=RequestMethod.POST)
    public ControllerResult productUpdate(Product product){
        logger.info("更新产品");
        productService.update(product);
        return ControllerResult.getSuccessResult("更新成功");
    }
    @ResponseBody
    @RequestMapping(value="deleteById/{id}", method=RequestMethod.GET)
    public ControllerResult productDelete(@PathVariable("id") int id){
        logger.info("删除产品");
        productService.deleteById(id);
        return ControllerResult.getSuccessResult("删除成功");
    }
}
