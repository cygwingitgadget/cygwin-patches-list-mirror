Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
 by sourceware.org (Postfix) with ESMTPS id 657F6385742D
 for <cygwin-patches@cygwin.com>; Fri, 21 May 2021 07:59:00 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 657F6385742D
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N6JtR-1lPyFX2ogL-016dWO for <cygwin-patches@cygwin.com>; Fri, 21 May 2021
 09:58:58 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 47333A82BFF; Fri, 21 May 2021 09:58:57 +0200 (CEST)
Date: Fri, 21 May 2021 09:58:57 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: PATCH] Cygwin: utils: chattr: Allow to clear all attributes with
 '='.
Message-ID: <YKdoQb1YVefI2As2@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <a8272535-f9a4-cbc0-d0ef-4d9040cc007f@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a8272535-f9a4-cbc0-d0ef-4d9040cc007f@t-online.de>
X-Provags-ID: V03:K1:FQz2DzAXpVLn7rguCP0mByVNNeuA3PWLUk3HpUWuUsGQR4wH4PS
 0rlhtOSWqiK0vi7xYSa5qZJP7PwPOd4bpLdfdRV4qZOxtEk76C9L5vegjFh+ife7NC21LrD
 ssrgwCIrAOgqbz3EJ8CeYo06Q/pkjj2AijiAzAPQNRMPVX9CwINoxjoyE4EVQdqF8AFQsIv
 9AlJXaUFFldxYv/Cg61Sw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mPoHmd3eRms=:FZ7L3IkSqYIcxAPjFPiq6f
 ZzD2yHNIqRUY7rRvXtWT5+3tb0xdpbLLeKKCOtJa3QIoKzYNk3KkPZx0bNdWWIJ/bl0+/L7nf
 lFrtbaek3BcpiYvSbTx5XAzg62jIA4CJe/pqIsmmwPiR99WJ+WzmIx0tDB8mE5SGjedMVOFrD
 AQSqmYWKNzG2SBZWF3YhkIcfkKJ02dw2DrJwBICOuikgDJxS7OlhJHo5Dqw6F0D7zM4Hdi30N
 qnQ3E5T4b1WOdAcQdmkDu0EWgBOEV/dvn23T48QjjaMQ1Ya9TecXheneBgNfLro/NsTlAbPIn
 GZIlvqM9yDexvpMulMYn2N4wJa6UFIQ2VZdQ68NW4blMSiJ5PuCxCCx6o+aLSe/fgwLN37icQ
 24P0VG29zKGZ5rbWpcI7C+Om5fOOZZOzw7cPyrye0s18oO22GQc7YLWQC9wTT4OxrDfEdkLFd
 Uz3asQQlq+l6n8cJTwXMzNlwJsvaYzqtxC1CJHqHggRMJhU/lFILrTyfnTmDfcGcdzAU0TnnZ
 wIHbhEe5apIVQ2FFjh3De0=
X-Spam-Status: No, score=-100.1 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_NONE, KAM_DMARC_STATUS,
 RCVD_IN_DNSWL_NONE, SPF_HELO_NONE, SPF_NEUTRAL,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Fri, 21 May 2021 07:59:01 -0000

On May 20 23:04, Christian Franke wrote:
> 'chattr = FILE' is shorter that 'chattr -rhsat... FILE' :-)

That's ok, but it might be worth to add this to the docs, too :)


Thanks,
Corinna
