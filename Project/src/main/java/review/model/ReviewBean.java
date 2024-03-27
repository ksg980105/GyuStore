package review.model;

import java.sql.Timestamp;

public class ReviewBean {
    private int review_number;
    private int product_number;
    private String user_id;
    private int rating;
    private String content;
    private Timestamp write_date;

    public int getReview_number() {
        return review_number;
    }

    public void setReview_number(int review_number) {
        this.review_number = review_number;
    }

    public int getProduct_number() {
        return product_number;
    }

    public void setProduct_number(int product_number) {
        this.product_number = product_number;
    }

    public String getUser_id() {
        return user_id;
    }

    public void setUser_id(String user_id) {
        this.user_id = user_id;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Timestamp getWrite_date() {
        return write_date;
    }

    public void setWrite_date(Timestamp write_date) {
        this.write_date = write_date;
    }
}

