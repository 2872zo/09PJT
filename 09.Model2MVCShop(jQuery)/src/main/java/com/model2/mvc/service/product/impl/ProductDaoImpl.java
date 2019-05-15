package com.model2.mvc.service.product.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductDao;

@Repository("productDao")
public class ProductDaoImpl implements ProductDao {
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public ProductDaoImpl() {
		System.out.println(this.getClass());
	}

	@Override
	public int addProduct(Product product) {		
		return (sqlSession.insert("ProductMapper.addProduct", product)==1 && (sqlSession.insert("ProductStockMapper.addProductStock",product)==1)?1:0);
	}

	@Override
	public Product getProduct(int prodNo) {
		return sqlSession.selectOne("ProductMapper.getProduct", prodNo);
	}

	@Override
	public int updateProduct(Product product) {
		return (sqlSession.update("ProductMapper.updateProduct", product)==1 && (sqlSession.update("ProductStockMapper.updateProductStock",product)==1)?1:0);
	}

	@Override
	public int deleteProduct(int prodNo) {
		return sqlSession.delete("ProductMapper.deleteProduct", prodNo);
	}

	@Override
	public List<Product> getProductList(Search search) {
		return sqlSession.selectList("ProductMapper.getProductList", search);
	}

	@Override
	public int makeTotalCount(Search search) {
		return sqlSession.selectOne("ProductMapper.makeTotalCount", search);
	}

}
