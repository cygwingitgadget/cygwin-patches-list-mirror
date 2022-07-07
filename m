Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
 by sourceware.org (Postfix) with ESMTPS id B52183858D32
 for <cygwin-patches@cygwin.com>; Thu,  7 Jul 2022 10:20:29 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org B52183858D32
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MPGBR-1nxdQn0Zqv-00PZqd for <cygwin-patches@cygwin.com>; Thu, 07 Jul 2022
 12:20:28 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 54CB0A807DB; Thu,  7 Jul 2022 12:20:27 +0200 (CEST)
Date: Thu, 7 Jul 2022 12:20:27 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH htdocs] Align setup help text in FAQ with setup 2.919
Message-ID: <YsazayJMXQfKlt5v@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <0d7b7998-60c3-a21a-71d5-2860bb198997@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0d7b7998-60c3-a21a-71d5-2860bb198997@t-online.de>
X-Provags-ID: V03:K1:phUTuqgZTzhayIwpcj12mga6Sya8wDkxqgxhQLXUwLwXEbiLg7T
 Xrge1OEOoKAWoYvDAw0JZT4K+KayRN9n57cvwBHOV8WCm+YoDb0Jv7y6UMPhl/YjnB62Bdv
 /7pmrgHnYdMcQMHzVIvwLHgLPZUDKWPFu1u83FwO/GuIcDb1HHtnWa4dQ1jLvv9o7LnxODf
 UYpqYB7BezxOPYxibsqcw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ThAIXGPvlds=:ONlvWw0XoA9xv4agieJqxq
 GFQGnu84oh57NXWVzXqlhKs/xcDvLr8t2o+aTIJKpY+4miaHxOBc16rOV3shnDedDF1UJWXB6
 +BwuWAq4xZC78vBwAIazLJsNv9hVI79ophh79Q/2Nr/04D5/um5zgWNcDIgKAwWLhHr2w11+0
 N9V3hprahk46iCsFmZ0pS+zZmvqz4NgWcRjmAMoW1WD8P90penc3dtDy5GX9tU6jojn9VJxd1
 5QXaJoosSCtg8P/KouUvCg5qcdBSC6v8BZvXkCHco0BqQQkNY2mciVQ0IDTeHo2wMZNHRWEWX
 dBTKJ1wNy7LpZQFypwGl7i6wGVme8flqpijLmvoFew330FVAk87xfpfbu4os+E1zo4W9NqXAz
 ODYUKqX7a7bBod/jZqCL9aVd2k+BdlO/U2Fkb9i/cF79JJ+WydNYHsu9P+B4PFV0B6DAOlHnK
 S8T58u2Vtj5Q/cTkCrpfu/q26AMW4dxqEBbLBKzG5RFMElfdrUmfDBGhNFgPNjynW0+0zlWcq
 eP3Ijdcl0pz7JhjsgaTkIDnoLTeb26GXxK0C3UZXBqSTFUCiGrNcBjD8vwYvodhpScWMGZeWw
 SAA8eYS6tuzd7PebEF09aWB+UktNzBv7amUss9xyvpMyB5WIAGIV1v+DzWWZad23QSWas0GnF
 RZS4ZLlh610woYUJffO50h38KKGQbEhV174AQ0lwPSv+CRC4Qgib5iKzIK4L/P6NoKWkhIvjR
 LN2ZcNdxr+fRPbaPSjK1Kni8rRqd06dZLOTjVKhDUL/upzlhZBmSCAi30Go=
X-Spam-Status: No, score=-94.8 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, KAM_NUMSUBJECT,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_FAIL, SPF_HELO_NONE, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
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
X-List-Received-Date: Thu, 07 Jul 2022 10:20:31 -0000

On Jul  7 12:08, Christian Franke wrote:
> Not sure whether cygwin-patches is the correct list for this patch,
> cygwin-htdocs is not mentioned in lists.html.

The FAQ is part of the Cygwin source, just clone the repo and create the
patch against winsup/doc/faq*.xml.


Thanks,
Corinna
