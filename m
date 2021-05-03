Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 by sourceware.org (Postfix) with ESMTPS id 5F375394848E
 for <cygwin-patches@cygwin.com>; Mon,  3 May 2021 10:48:45 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 5F375394848E
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MKbc2-1lrkgx0bBE-00Kzlm for <cygwin-patches@cygwin.com>; Mon, 03 May 2021
 12:48:44 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 935A9A80D64; Mon,  3 May 2021 12:48:41 +0200 (CEST)
Date: Mon, 3 May 2021 12:48:41 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 2/2] Move source files used in utils/mingw/ into that
 subdirectory
Message-ID: <YI/VCcOj36ydUiEw@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210502152537.32312-1-jon.turney@dronecode.org.uk>
 <20210502152537.32312-3-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210502152537.32312-3-jon.turney@dronecode.org.uk>
X-Provags-ID: V03:K1:Melx1NP+mGgfmddsArFsg1N2pZ1wBLigiWHIb6pNwF/cG7hS1Lp
 O9vonFDWpFkRvlwEh3bEfeCq5p1vN/4p98bpOyHP/WUZMVi+KVr9OAKsPDl2cvgeQ0NXKBL
 kYtbzxW8BkCWOIDCNcp5T9EOXL+aXcM5xKx/zE1SPvk3rWYRzeG7s5nOHa7aiVyX3NPNCjD
 ZTEebSaeLQFkkhZNwSZrw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5+ZA8LDa54k=:DYKiBnusXGcrEcwGAxFHvn
 EOd166knFX33xgogtjqVhqpcfgXuQ/q1JTBOlIkX/LeEDMbxeU8Hm3WGgJKlAcyJRI5XDTFbh
 De9tbEZP4F7lKF+vSjoyUUZNfN9cMGL5tJWEQZ+23XWap5wwL0M5IqwyhzeQWj4NVbieqq4QQ
 NbTyhzTj/1m/bM2/K6E+rb/MNb7Kp/+gLa98qTU30xFiqw3Q7X+YgRWtnYiH4Q5C202l+dqsR
 RgcxwX+cwZosKrcnF7VFdsrnNIAxFU031j6HExEVp1RoX7YUk7AJnT5CtR3EAmGmfw4X4J3MT
 b+jvd4+flT6TUMS4SyOVRUz3+V8citBZ96GRXkINWzpLVyEhYYSHVxweNb5rhGqxBCfjJdCiC
 eTm/cJaN69b+cEL5Kzcu1CXHo/RTzQOQtd8RZjZUByQ1ZYqZYweDI+Zj+B3o3qP8iGDQ07kFq
 R2nhEAz5GJ0H8eK3e7hU6I087Q9Gxc+rmjYawWse38oSnhMuDh117eKG1Shiae+fm6Y8qLuHA
 8DVByVFGq9RfAOEtWGWjJg=
X-Spam-Status: No, score=-100.1 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_NONE, KAM_DMARC_STATUS,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H4, RCVD_IN_MSPIKE_WL, SPF_HELO_NONE,
 SPF_NEUTRAL, TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Mon, 03 May 2021 10:48:49 -0000

On May  2 16:25, Jon Turney wrote:
> Move all the source files used in utils/mingw/ into that subdirectory,
> so the built objects are in the expected place.
> 
> (path.cc requires some more unpicking, and even then there is genuinely
> some shared code, so use a trivial file which includes the real path.cc
> so the object file is generated where expected)

This patchset LGTM, except one thing which isn't your fault:

> index b96ad40c1..a7797600c 100644
> --- a/winsup/utils/strace.cc
> +++ b/winsup/utils/mingw/strace.cc
> @@ -21,11 +21,11 @@ details. */
>  #include <time.h>
>  #include <signal.h>
>  #include <errno.h>
> -#include "../cygwin/include/sys/strace.h"
> -#include "../cygwin/include/sys/cygwin.h"
> -#include "../cygwin/include/cygwin/version.h"
> -#include "../cygwin/cygtls_padsize.h"
> -#include "../cygwin/gcc_seh.h"
> +#include "../../cygwin/include/sys/strace.h"
> +#include "../../cygwin/include/sys/cygwin.h"
> +#include "../../cygwin/include/cygwin/version.h"
> +#include "../../cygwin/cygtls_padsize.h"
> +#include "../../cygwin/gcc_seh.h"

What about adding -I../../cygwin -I../../cygwin/include to the build
rules and get rid of the relative paths inside the sources?


Thanks,
Corinna
