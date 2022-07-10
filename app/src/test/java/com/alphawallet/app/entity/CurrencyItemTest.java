package com.alphawallet.app.entity;

import static org.hamcrest.CoreMatchers.equalTo;
import static org.hamcrest.MatcherAssert.assertThat;

import org.junit.Test;

import im.vector.app.R;

public class CurrencyItemTest {
    @Test
    public void getCurrencyText() {
        CurrencyItem currencyItem = new CurrencyItem("USD", "American Dollar", "$", R.drawable.ic_flags_usa);
        assertThat(currencyItem.getCurrencyText(3124.56), equalTo("3,124.56 USD"));
    }
}
