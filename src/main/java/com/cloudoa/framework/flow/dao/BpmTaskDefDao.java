package com.cloudoa.framework.flow.dao;

import org.springframework.stereotype.Component;

import com.cloudoa.framework.flow.entity.BpmTaskDef;
import com.cloudoa.framework.orm.hibernate.HibernateDao;

@Component
public class BpmTaskDefDao extends HibernateDao<BpmTaskDef,Long> {
}
