package shop.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import shop.bean.User;
import shop.bean.UserExample;
import shop.mapper.UserMapper;

import java.util.List;

@Service
public class UserService {

    @Autowired
    private UserMapper userMapper;

    public List<User> getAll(){
        return userMapper.selectByExample(null);
    }

    public User getUserByUser(User toUser) {
        UserExample example = new UserExample();
        UserExample.Criteria criteria = example.createCriteria();
        criteria.andUsernameEqualTo(toUser.getUsername());
        criteria.andPasseordEqualTo(toUser.getPasseord());
        //List<User> userList = userMapper.selectByExample(example);
        List<User> userList = userMapper.selectByExampleWithCart(example);
        if (userList != null && userList.size() == 1){
            return userList.get(0);
        }else {
            return null;
        }
    }

    public User getUserByUid(Integer uid) {
        return userMapper.selectByPrimaryKeyWithCart(uid);
    }

    public boolean usernameCheck(String username) {
        UserExample example = new UserExample();
        UserExample.Criteria criteria = example.createCriteria();
        criteria.andUsernameEqualTo(username);
        List<User> list = userMapper.selectByExample(example);
        if(list.size() != 0){
            return false;
        } else {
            return true;
        }
    }

    public void addUser(User user) {
        userMapper.insertSelective(user);
    }
}
