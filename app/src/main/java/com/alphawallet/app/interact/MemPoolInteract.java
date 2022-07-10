package com.alphawallet.app.interact;

import com.alphawallet.app.entity.TransferFromEventResponse;
import com.alphawallet.app.repository.TokenRepositoryType;

import javax.inject.Inject;

import io.reactivex.Observable;

/**
 * Created by James on 1/02/2018.
 */

public class MemPoolInteract
{
    private final TokenRepositoryType tokenRepository;

    @Inject
    public MemPoolInteract(TokenRepositoryType tokenRepository) {
        this.tokenRepository = tokenRepository;
    }

    //create an observable
    public Observable<TransferFromEventResponse> burnListener(String contractAddress) {
        return tokenRepository.burnListenerObservable(contractAddress);
    }
}
