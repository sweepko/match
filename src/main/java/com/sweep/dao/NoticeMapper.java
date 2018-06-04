package com.sweep.dao;

import com.sweep.pojo.Notice;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface NoticeMapper {
    int deleteByPrimaryKey(Integer noticeid);

    int insert(Notice record);

    int insertSelective(Notice record);

    Notice selectByPrimaryKey(Integer noticeid);

    int updateByPrimaryKeySelective(Notice record);

    int updateByPrimaryKey(Notice record);

    List<Notice> selectAllNotice();

    List<Notice> selectNoticeByKeyWord(String keyword);


    int deleteByPrimaryKeys(@Param("ids") String ids);
}