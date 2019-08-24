package shop.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import shop.bean.Category;
import shop.bean.CategoryExample;
import shop.bean.CategorySecond;
import shop.mapper.CategoryMapper;

import java.util.ArrayList;
import java.util.List;

@Service
public class CategoryService {

    @Autowired
    CategoryMapper mapper;

    public List<Category> getAll() {
        return mapper.selectByExample(null);
    }


    public void deleteByCid(int i) {
        mapper.deleteByPrimaryKey(i);
    }

    public void updateByCid(Category category) {
        mapper.updateByPrimaryKey(category);
    }

    public void add(Category category) {
        mapper.insert(category);
    }

    public Boolean check(String cname) {
        CategoryExample example = new CategoryExample();
        CategoryExample.Criteria criteria = example.createCriteria();
        criteria.andCnameEqualTo(cname);
        long count = mapper.countByExample(example);
        System.out.println(cname);
        System.out.println(count);
        return count == 0;
    }

    public List<Category> getAllWithSeconds() {
        return mapper.selectByExampleWithSeconds(null);
    }

    public List<Integer> getCisdsByCid(Integer cid){
        Category category = mapper.selectByPrimaryKeyWithSeconds(cid);
        List<CategorySecond> categorySeconds = category.getCategorySeconds();
        List<Integer> cids = new ArrayList<>();
        for (CategorySecond categorySecond:categorySeconds) {
             cids.add(categorySecond.getCsid());
        }
        return cids;
    }
}
