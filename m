Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
 by sourceware.org (Postfix) with ESMTPS id 0ADB43860C37
 for <cygwin-patches@cygwin.com>; Mon,  1 Feb 2021 19:02:17 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 0ADB43860C37
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N9MlI-1m32Sq2EeS-015HWf for <cygwin-patches@cygwin.com>; Mon, 01 Feb 2021
 20:02:16 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id F09B3A80708; Mon,  1 Feb 2021 20:02:15 +0100 (CET)
Date: Mon, 1 Feb 2021 20:02:15 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] CYGWIN:  Fix resolver debugging output
Message-ID: <20210201190215.GA4251@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210129192903.939-1-lavr@ncbi.nlm.nih.gov>
 <20210201103445.GK375565@calimero.vinschen.de>
 <DM8PR09MB7095CE3228ED706E16BA0F16A5B69@DM8PR09MB7095.namprd09.prod.outlook.com>
 <20210201150209.GP375565@calimero.vinschen.de>
 <DM8PR09MB70952B27AFDF02848ABB50C7A5B69@DM8PR09MB7095.namprd09.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DM8PR09MB70952B27AFDF02848ABB50C7A5B69@DM8PR09MB7095.namprd09.prod.outlook.com>
X-Provags-ID: V03:K1:dki+wNNPnUGJgwWZnNqsig4kqMviwXdQq6kjxO0F4XJINAoOqHG
 NJ9jH896lPKP/HMFd/g0Yteb4NmNFm1+LQp04iqXhZc6AY7wHWth/xqKzHsTpV+Z79t/7Iw
 ZHfBhJ9cBy3pTByqcE2g2BKD8xbnQSKdvke3naK1bcyuZT0zRbctDC927j2nZnzjv3LuidC
 bNJ3pOJn0MOVqvT3QhHdg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1FQuvQsJ5f8=:H/uqYm/feiXXQLF4uHQU4J
 tUi4hUyy5GpEkCOfb61UmA4u2Q7a10xSEEOyIMaF5bd1BO2fvIJOCGVQp8/6D9fj3HRzo+fNL
 1c1JFXMHRfbFGWBdJsxJXIMew3i0GvNQlpUI4ZqzcvIlW5dKF+xVQTV9ri8R+w73VMF7CWkdN
 5BQ/K08Cb6RRICDboJlJ2ZbSHJcm5XUbzyn+2PKh6nSHYsuQAlRDBoNzE0W35Ad5iDXPlen9Q
 dp3vNcZVC64bJSqeISoUUQnHp1YiYUlcIonodi3UdH8pN0kgGw0qOx5ljIOsKYRcCdPdz8dOh
 jrwmtJp1OtRUAeYdv3nkkClhLKc1L7bxDByi399PTKLcpZFqVKpS3OxEeqBAYKHvz7vAx55k1
 +z3kDZbLNHlSZTGsysXvSLP2ne66r3oMroXoWbi1NFG8Hd5INiU0vexqTAzD33ILLF7WdPxhD
 cMqCrOGBaw==
X-Spam-Status: No, score=-101.3 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
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
X-List-Received-Date: Mon, 01 Feb 2021 19:02:19 -0000

On Feb  1 15:46, Lavrentiev, Anton (NIH/NLM/NCBI) [C] via Cygwin-patches wrote:
> > Except, the value has no meaning for ipv6.
> 
> It'll print all 0's :-)  But:
> 
> minires does not make use of the _ext field.  It does use the conventional nsaddr_list (which is IPv4),
> but only if Windows native DNS API is not used: "osquery"(aka use_os)=0.
> 
> For debugging purposes, that is enough and very convenient (yet the output needed some tune-up, which I suggested in my patch).

Ok.

> But for practical purposes, only Windows API should be used in regular applications (which is the default, anyways, since
> /etc/resolv.conf is not routinely provided, so "osquery=1" implicitly).

Yeah, I think so, too.  Ideally we should have stripped out all code
providing non-Windows means (i. e., /etc/resolv.conf support) back when
this code was folded into Cygwin.  It just doesn't make sense, at least
not by default.

> I'm not sure if improvements to use _ext by the minires own code would be any beneficial.
> 
> Having said that, AAAA replies should be made understood by the minires-if-os shim code
> (and I can provide a patch for that, too).

That would be great!


Thanks,
Corinna
