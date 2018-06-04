package com.sweep.service.impl;

import com.sweep.dao.NoticeMapper;
import com.sweep.pojo.Notice;
import com.sweep.service.NoticeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class NoticeServiceImpl implements NoticeService{
    @Autowired
    private NoticeMapper noticeMapper;
    @Override
    public boolean insertNotice(Notice notice) {
        return noticeMapper.insert(notice)>0;
    }

    @Override
    public List<Notice> selectNotice(String keyword) {
        if (keyword==null){
            return noticeMapper.selectAllNotice();
        }else{
            return noticeMapper.selectNoticeByKeyWord(keyword);
        }

    }

    @Override
    public int deleteNotices(String ids) {
        return noticeMapper.deleteByPrimaryKeys(ids);
    }

    @Override
    public Notice selectNoticeById(int noticeid) {
        return noticeMapper.selectByPrimaryKey(noticeid);
    }

    @Override
    public boolean updateNotice(Notice notice) {
        return noticeMapper.updateByPrimaryKeySelective(notice)>0;
    }

    @Override
    public List<Notice> getAllNotice() {
        return noticeMapper.selectAllNotice();
    }
}
