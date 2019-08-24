package shop.mapper;

import org.apache.ibatis.annotations.Param;
import shop.bean.AdminUser;
import shop.bean.AdminUserExample;

import java.util.List;

public interface AdminUserMapper {
    long countByExample(AdminUserExample example);

    int deleteByExample(AdminUserExample example);

    int deleteByPrimaryKey(Integer aid);

    int insert(AdminUser record);

    int insertSelective(AdminUser record);

    List<AdminUser> selectByExample(AdminUserExample example);

    AdminUser selectByPrimaryKey(Integer aid);

    int updateByExampleSelective(@Param("record") AdminUser record, @Param("example") AdminUserExample example);

    int updateByExample(@Param("record") AdminUser record, @Param("example") AdminUserExample example);

    int updateByPrimaryKeySelective(AdminUser record);

    int updateByPrimaryKey(AdminUser record);
}