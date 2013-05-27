package com.raysmond.db.dao;

import java.util.HashMap;
import java.util.List;

public interface BaseDao<T> {
	public int insert(T entity);
	public boolean update(T entity);
	public boolean delete(T entity);
	public List<T> find(T entity);
	public List<T> find(HashMap<String,String> map);
}
