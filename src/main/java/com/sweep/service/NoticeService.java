package com.sweep.service;

import com.sweep.pojo.Notice;

import java.util.List;

public interface NoticeService {
    public boolean insertNotice(Notice notice);
    public List<Notice> selectNotice(String keyword);
    public int deleteNotices(String ids);
    public Notice selectNoticeById(int noticeid);
    public boolean updateNotice(Notice notice);
}
