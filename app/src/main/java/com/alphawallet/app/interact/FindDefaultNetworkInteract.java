package com.alphawallet.app.interact;

import com.alphawallet.app.repository.EthereumNetworkRepositoryType;
import com.alphawallet.app.entity.NetworkInfo;

import javax.inject.Inject;

public class FindDefaultNetworkInteract {

    private final EthereumNetworkRepositoryType ethereumNetworkRepository;

    @Inject
    public FindDefaultNetworkInteract(EthereumNetworkRepositoryType ethereumNetworkRepository) {
        this.ethereumNetworkRepository = ethereumNetworkRepository;
    }

    public String getNetworkName(long chainId)
    {
        return ethereumNetworkRepository.getNetworkByChain(chainId).getShortName();
    }

    public NetworkInfo getNetworkInfo(long chainId)
    {
        return ethereumNetworkRepository.getNetworkByChain(chainId);
    }
}
