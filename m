Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
 by sourceware.org (Postfix) with ESMTPS id F1F7B386F443
 for <cygwin-patches@cygwin.com>; Mon,  7 Sep 2020 08:33:26 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org F1F7B386F443
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M2OEw-1kGroh2YIw-003uIK for <cygwin-patches@cygwin.com>; Mon, 07 Sep 2020
 10:33:25 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 0CFCEA83A8B; Mon,  7 Sep 2020 10:33:25 +0200 (CEST)
Date: Mon, 7 Sep 2020 10:33:25 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 3/3] fhandler_pty_slave::setup_locale: respect charset ==
 "UTF-8"
Message-ID: <20200907083325.GE4127@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200902083014.GH4127@calimero.vinschen.de>
 <20200902083818.GI4127@calimero.vinschen.de>
 <20200902195412.aa7f233231d893a7a065b691@nifty.ne.jp>
 <20200902152450.GJ4127@calimero.vinschen.de>
 <20200903012500.640e36573c67328fc3e1bc70@nifty.ne.jp>
 <20200902163836.GL4127@calimero.vinschen.de>
 <20200903175912.GP4127@calimero.vinschen.de>
 <20200904182149.18cd752eef58c67ee8d39135@nifty.ne.jp>
 <20200904124400.GQ4127@calimero.vinschen.de>
 <20200906192848.0394f5d208edda68a9fec991@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200906192848.0394f5d208edda68a9fec991@nifty.ne.jp>
X-Provags-ID: V03:K1:0dQKh+SgauQEZM4LmdNIdGKn+Eha9ggc/Ia7/ELrTt3UCAM0UqS
 7tNxqtus23f+vtFsEKtigQOz7iNgrNIqKkz0xjTawxapGjz9NBKzPsrYgQRNNKNdgWJs7JT
 1F5xk/7klWcsn44VN8N3AvLl77lqmMCiqhUxe+QAxChhGpF8BaCppnrDiA2qbAyViRKZtZy
 p2ZcpfYNKBSe4z3RkGBww==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ICSc7CDyAk4=:agpOgUS6HFqdmVCA/8lRas
 ukIrh/9fCDESfaOVI3E8irggnykoojIY/fDKH87+lT1bpSLNKpChWnC65ECx7UdCiN0Q9kRe/
 qJCNbNogUUKZ2TxHiqmisJCrlYl04Md+jLCsIfELSV6yDcLw14HiRjm1ikX97mQaTdEGfZsB2
 n999OZo4yJvCfP7jPf65XGOAe7ikB6phMBmgHigsNr9JuKbEkk0++5AsEC5gJL7wK3wU7e0XW
 cHJVXyXF3tNd/kfeSadZR6RQabg4tDrCVO5kLuqzk5RxclY7U1dxviahZ0ikojdj63t6cfBnd
 YubimLxKS35N6pfnHt+3LgEvsVTE43pAa1iOpo0GEYOMCCHhocRza9kSEHUY1i8YBOjY9c80x
 E9FcaFjIMDBTmSwfc5OiPlaAoOGW1PD3IJiie5Ic7MFdfZTWkx3OYbrs9bqurbztLo+UtibWt
 nXgP1FceM+wzeWsoGYHR3oXX5veO3HZZtTuD+k2GTbpBnDQ/Npat37OpftxiEBzVXDxiPq18J
 WquoEDykZ6TgFbedsVPBZVxmYKZ4It6dQU09FA0bflghlT40Svhz8e23Uga09h0QqdOIKGqT3
 1ROlHVsP7Spao32WkZl04iPJh8PwmK4vohZmI097NqKRNc/w0cD+56TpLuEKnjtFdJy8vZ0/L
 QlPg3rng/qVbBKwgJoWSOh7SANGEeBwVn6jqsTaLq7tzxUZosuP8inGBN81v17LJjDAs9ijjn
 F2u7dbR2hJf6NPrBbf+JbU7qsKq3vQ7Jm36Vnfj58ZBOSMIurymxEBInAqe5H3QFOtyBbo/KH
 B0gFVOjd8m0JYSteeDV2387XIaItrDvz4C0Q2dDlY/b6Egy2xWQy4BJyyLy8w5UghQLXjQxnV
 DgT9SAREJVY4v92wHRcQ==
X-Spam-Status: No, score=-100.3 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_STATUS,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
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
X-List-Received-Date: Mon, 07 Sep 2020 08:33:28 -0000

On Sep  6 19:28, Takashi Yano via Cygwin-patches wrote:
> Hi Corinna,
> 
> On Fri, 4 Sep 2020 14:44:00 +0200
> Corinna Vinschen <corinna-cygwin@cygwin.com> wrote:
> > +    case 'I': /* ISO-8859-x */
> > +      codepage = strtoul (charset + 9, NULL, 10);
> > +      break;
> 
> This should be:
> codepage = strtoul (charset + 9, NULL, 10) + 28590;
> shouldn't it?

Thanks for catching!


Corinna
