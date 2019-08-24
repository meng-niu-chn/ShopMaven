package shop.mapper;

import org.apache.ibatis.annotations.Param;
import shop.bean.Commomt;
import shop.bean.CommomtExample;

import java.util.List;

public interface CommomtMapper {
    long countByExample(CommomtExample example);

    int deleteByExample(CommomtExample example);

    int deleteByPrimaryKey(Integer comid);

    int insert(Commomt record);

    int insertSelective(Commomt record);

    List<Commomt> selectByExample(CommomtExample example);

    Commomt selectByPrimaryKey(Integer comid);

    int updateByExampleSelective(@Param("record") Commomt record, @Param("example") CommomtExample example);

    int updateByExample(@Param("record") Commomt record, @Param("example") CommomtExample example);

    int updateByPrimaryKeySelective(Commomt record);

    int updateByPrimaryKey(Commomt record);
}