package com.xk.controller;

import com.xk.bean.Product;
import com.xk.common.bean.ControllerResult;
import com.xk.common.bean.Pager4EasyUI;
import com.xk.service.ProductService;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by xiao-kang on 2017/2/15.
 */
@Controller
@RequestMapping("/product")
public class ProductController {

    @Resource
    private ProductService productService;

    @RequestMapping(value="product_page",method = RequestMethod.GET)
    public String showProduct(){
        return "product";
    }

    @ResponseBody
    @RequestMapping(value="query_pager",method=RequestMethod.GET)
    public List<Product> queryPager(@Param("page")String page, @Param("rows")String rows){
        Pager4EasyUI<Product> pager = new Pager4EasyUI<Product>();
        pager.setPageNo(Integer.valueOf(page));
        pager.setPageSize(Integer.valueOf(rows));
        Product product = new Product();
        //product.setName("2");
        pager = productService.queryByPagerAndCriteria(pager,product);
        return pager.getRows();
    }

    @ResponseBody
    @RequestMapping(value="add", method=RequestMethod.POST)
    public ControllerResult productAdd(Product product){
        productService.add(product);
        return ControllerResult.getSuccessResult("添加成功");
    }

    @ResponseBody
    @RequestMapping(value="update", method=RequestMethod.POST)
    public ControllerResult productUpdate(Product product){
        productService.update(product);
        return ControllerResult.getSuccessResult("更新成功");
    }
    @ResponseBody
    @RequestMapping(value="deleteById/{id}", method=RequestMethod.GET)
    public ControllerResult productDelete(@PathVariable("id") int id){
        System.out.print("---------------"+id);
        productService.deleteById(id);
        return ControllerResult.getSuccessResult("删除成功");
    }
}
