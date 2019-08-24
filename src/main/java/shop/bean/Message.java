package shop.bean;

import java.util.HashMap;
import java.util.Map;

public class Message {
    private int code;
    private String msg;
    private Map<String, Object> extendMap = (Map<String, Object>) new HashMap();

    public static Message success() {
        Message result = new Message();
        result.setCode(200);
        result.setMsg("success");

        return result;
    }

    public static Message fail() {
        Message result = new Message();
        result.setCode(100);
        result.setMsg("fail");

        return result;
    }

    public int getCode() {
        return code;
    }
    public void setCode(int code) {
        this.code = code;
    }
    public String getMsg() {
        return msg;
    }
    public void setMsg(String msg) {
        this.msg = msg;
    }
    public Map<String, Object> getExtendMap() {
        return extendMap;
    }
    public void setExtendMap(Map<String, Object> extendMap) {
        this.extendMap = extendMap;
    }

    public Message add(String key,Object value) {
        this.getExtendMap().put(key,value);
        return this;
    }
}
