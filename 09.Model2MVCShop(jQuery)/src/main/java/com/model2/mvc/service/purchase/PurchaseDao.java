package com.model2.mvc.service.purchase;

import java.util.List;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;

public interface PurchaseDao{
	public int addPurchase(Purchase purchase);
	
	public Purchase getPurchase(int tranNo);

	public int updatePurchase(Purchase purchase);
	
	public int updateTranCode(Purchase purchase);

	public int deletePurchase(int tranNo);

	public List<Purchase> getPurchaseList(Search search);

	public int makeTotalCount(Search search);

	public int cancelTranCode(Purchase purchase);
	
	public List<Product> getCartView(Search search);

	public void deleteCart(Search search);

	public void addCart(Search search);
}
