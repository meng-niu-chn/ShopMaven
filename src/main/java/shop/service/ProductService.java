package shop.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import shop.bean.Product;
import shop.bean.ProductExample;
import shop.mapper.ProductMapper;

import java.util.List;

@Service
public class ProductService {
    @Autowired
    ProductMapper mapper;
    @Autowired
    CategoryService categoryService;

    public List<Product> getAll() {
        return mapper.selectByExampleWithCS(null);
    }

    public void deleteByPid(Integer pid) {
        mapper.deleteByPrimaryKey(pid);
    }

    public void updateByPid(Product product) {
        mapper.updateByPrimaryKeySelective(product);
    }

    public void add(Product product) {
        mapper.insertSelective(product);
    }

    public List<Product> getProductsByCsid(Integer csid) {
        ProductExample example = new ProductExample();
        ProductExample.Criteria  criteria = example.createCriteria();
        criteria.andCsidEqualTo(csid);
        List<Product> products = mapper.selectByExample(example);
        return products;
    }

    public List<Product> getProductsByCid(Integer cid) {
        ProductExample example = new ProductExample();
        ProductExample.Criteria  criteria = example.createCriteria();
        criteria.andCsidIn(categoryService.getCisdsByCid(cid));
        List<Product> products = mapper.selectByExample(example);
        return products;
    }

    public List<Product> getProductsByCsids(List<Integer> csids) {
        ProductExample example = new ProductExample();
        ProductExample.Criteria  criteria = example.createCriteria();
        criteria.andCsidIn(csids);
        List<Product> products = mapper.selectByExample(example);
        return products;
    }

    public List<Product> getHotProducts() {
        ProductExample example = new ProductExample();
        ProductExample.Criteria  criteria = example.createCriteria();
        criteria.andIsHotEqualTo(1);
        List<Product> products = mapper.selectByExample(example);
        return products;
    }

    public List<Product> getNewProducts() {
        ProductExample example = new ProductExample();
        ProductExample.Criteria  criteria = example.createCriteria();
        example.setOrderByClause("pdate DESC");
        List<Product> products = mapper.selectByExample(example);

        return products;
    }

    public Product getProductByPid(Integer pid) {
        return mapper.selectByPrimaryKey(pid);
    }
}
