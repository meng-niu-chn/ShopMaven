package shop.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import shop.bean.CategorySecond;
import shop.bean.CategorySecondExample;
import shop.mapper.CategorySecondMapper;

import java.util.List;

@Service
public class CategorySecondService {

    @Autowired
    CategorySecondMapper mapper;

    public List<CategorySecond> getAll() {
        return mapper.selectByExampleWithCate(null);
    }

    public void deleteByCsid(Integer csid) {
        mapper.deleteByPrimaryKey(csid);
    }

    public void updateByExample(CategorySecond categorySecond) {
        //mapper.updateByExampleSelective(categorySecond);
        mapper.updateByPrimaryKeySelective(categorySecond);
    }

    public void add(CategorySecond categorySecond) {
        mapper.insertSelective(categorySecond);
    }

    public boolean check(String csname) {
        CategorySecondExample example = new CategorySecondExample();
        CategorySecondExample.Criteria criteria = example.createCriteria();
        criteria.andCsnameEqualTo(csname);
        long count = mapper.countByExample(example);
        return count == 0;
    }
}
