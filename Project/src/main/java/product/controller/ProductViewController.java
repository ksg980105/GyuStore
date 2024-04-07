package product.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import category.model.CategoryBean;
import category.model.CategoryDao;
import product.model.ProductBean;
import product.model.ProductDao;
import utility.Paging;

@Controller
public class ProductViewController {

	private final String command = "/view.product";
	private final String viewPage = "productView";
	
	@Autowired
	private ProductDao productDao;
	
	@Autowired
	private CategoryDao categoryDao;
	
	@RequestMapping(value = command, method = RequestMethod.GET)
	public String viewGet(Model model, @RequestParam(value = "category", required = false) String category,
						  @RequestParam(value = "whatColumn", required = false) String whatColumn,
						  @RequestParam(value = "keyword", required = false) String keyword,
						  @RequestParam(value = "pageNumber", required = false) String pageNumber,
						  @RequestParam(value = "price_order", required = false) String price_order,
						  HttpServletRequest request) {
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("category", category);
		map.put("whatColumn", whatColumn);
		map.put("keyword", "%" + keyword + "%");
		map.put("price_order", price_order);
		
		int totalCount = productDao.getTotalCount(map);
		System.out.println("totalCount:" + totalCount);
		String url = request.getContextPath() + command;
		
		Paging pageInfo = new Paging(pageNumber, "12", totalCount, url, whatColumn, keyword);
		
		List<ProductBean> lists = productDao.getAllProduct(map, pageInfo);
		
		List<CategoryBean> categoryList = categoryDao.getAllCategory();
		
		model.addAttribute("productList", lists);
		model.addAttribute("productPageInfo", pageInfo);
		model.addAttribute("categoryList", categoryList);
		
		return viewPage;
	}
	
}
