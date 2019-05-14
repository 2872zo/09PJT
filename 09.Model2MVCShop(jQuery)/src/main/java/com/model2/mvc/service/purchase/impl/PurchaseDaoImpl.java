package com.model2.mvc.service.purchase.impl;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.purchase.PurchaseDao;

@Repository("purchaseDao")
public class PurchaseDaoImpl implements PurchaseDao{
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public PurchaseDaoImpl() {
		System.out.println(this.getClass());
	}
	
	@Override
	public int addPurchase(Purchase purchase) {
		return (sqlSession.insert("PurchaseMapper.addPurchase", purchase)==1 && sqlSession.update("ProductStockMapper.decreaseStock",purchase)==1)?1:0;
	}

	@Override
	public Purchase getPurchase(int tranNo) {
		return sqlSession.selectOne("PurchaseMapper.getPurchase", tranNo);
	}

	@Override
	public int updatePurchase(Purchase purchase) {
		return sqlSession.update("PurchaseMapper.updatePurchase", purchase);
	}
	
	@Override
	public int updateTranCode(Purchase purchase) {
		return sqlSession.update("PurchaseMapper.updateTranCode", purchase);
	}

	@Override
	public int deletePurchase(int tranNo) {
		return sqlSession.delete("PurchaseMapper.deletePurchase", tranNo);
	}

	@Override
	public List<Purchase> getPurchaseList(Search search) {
		return sqlSession.selectList("PurchaseMapper.getPurchaseList", search);
	}

	@Override
	public int makeTotalCount(Search search) {
		return sqlSession.selectOne("PurchaseMapper.makeTotalCount", search);
	}

	@Override
	public int cancelTranCode(Purchase purchase) {
		return sqlSession.update("ProductStockMapper.cancelPurchase", purchase);
	}

	public List<Product> getCartView(Search search) {
		return sqlSession.selectList("CartMapper.getCart",search);
	}

	@Override
	public void deleteCart(Search search) {
		System.out.println(sqlSession.delete("CartMapper.deleteCart",search));		
	}

	@Override
	public void addCart(Search search) {
		System.out.println(sqlSession.insert("CartMapper.addCart",search));		
		
	}
}
