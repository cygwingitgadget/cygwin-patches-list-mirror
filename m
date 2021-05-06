Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 by sourceware.org (Postfix) with ESMTPS id 771443860C3B
 for <cygwin-patches@cygwin.com>; Thu,  6 May 2021 08:43:34 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 771443860C3B
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1M1YlB-1lfwWF2GK3-0032ba for <cygwin-patches@cygwin.com>; Thu, 06 May 2021
 10:43:32 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 9D6E9A80DBD; Thu,  6 May 2021 10:43:30 +0200 (CEST)
Date: Thu, 6 May 2021 10:43:30 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 2/2] Move source files used in utils/mingw/ into that
 subdirectory
Message-ID: <YJOsMrJr+rC8EZHU@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210502152537.32312-1-jon.turney@dronecode.org.uk>
 <20210502152537.32312-3-jon.turney@dronecode.org.uk>
 <YI/VCcOj36ydUiEw@calimero.vinschen.de>
 <0d4d3343-45ec-2e25-0985-e99db9b46c01@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0d4d3343-45ec-2e25-0985-e99db9b46c01@dronecode.org.uk>
X-Provags-ID: V03:K1:L0V7o+VfPH93UMZ5oPL00ORnj0dk7LkXqjk3mr8akFGJrmTVseO
 g1ff6ytEM/mGeKmcCLocBj3zehZDioS3l3zco8oEEbHT+kpjxctRISsZ4qCrhSOFY7ugXQ/
 nPala5KXzICgZeE2JZYORrNHYngoxNC1OS/dGUSiSYSlWOeuQNusXD0D6kT+r7hM24/ge17
 ruxa7n2U7V+/Sryjz+ZMg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:j+zttgts2ts=:uTncq8QcYDJ0VQTOhk7Rnj
 MX9a31AHzCFijvtpQvHavuNmJSU9NYvkApE1MEOZlFEkta9Bb9BNdShQDlik8/eCeRv4kKsTu
 j9kcDj1GquS+7wTNk4yGZI1jIy1ug/3sZUPDaOplyYzXfKFswdCWjvCi2PoeyPDgjffZYoO3r
 4qWX5TWmtAjdzx3KUegzXUcoKLBvQKF+JmQrkPqdp4uYibwXiB7DhM7UrOVtI5OJHGJ5khX0v
 bMopYsqu22Zl2+qnPp76yGnJ0EiD66WtScdBOuK5/hVJT02HmX1Sct28tPdYdc0aoN4SSFVzF
 HAhaExs198NoMf8BohPeV4/3k8i36uGUKgS9AK++Uh/At9cbewLQpkL4M99cx+OzplaukkRNg
 0AtI4kXlFD/Zhg3O9iO4AQbwhIhELoGRCfjSRARca6lZA5FsZrTGK7YIZNBQJjwka1rSZNamg
 lXi++mdnOYp/DYK6hvy0hRPojN3jK1Y61oJCHzl9DveqtkWFPL8ox49jc8+brXli+nJy303Vn
 znFPwqdeZuEqEtzgNNHwog=
X-Spam-Status: No, score=-100.1 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_NONE, KAM_DMARC_STATUS,
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
X-List-Received-Date: Thu, 06 May 2021 08:43:36 -0000

On May  4 19:34, Jon Turney wrote:
> On 03/05/2021 11:48, Corinna Vinschen wrote:
> > On May  2 16:25, Jon Turney wrote:
> > > Move all the source files used in utils/mingw/ into that subdirectory,
> > > so the built objects are in the expected place.
> > > 
> > > (path.cc requires some more unpicking, and even then there is genuinely
> > > some shared code, so use a trivial file which includes the real path.cc
> > > so the object file is generated where expected)
> > 
> > This patchset LGTM, except one thing which isn't your fault:
> > 
> > > index b96ad40c1..a7797600c 100644
> > > --- a/winsup/utils/strace.cc
> > > +++ b/winsup/utils/mingw/strace.cc
> > > @@ -21,11 +21,11 @@ details. */
> > >   #include <time.h>
> > >   #include <signal.h>
> > >   #include <errno.h>
> > > -#include "../cygwin/include/sys/strace.h"
> > > -#include "../cygwin/include/sys/cygwin.h"
> > > -#include "../cygwin/include/cygwin/version.h"
> > > -#include "../cygwin/cygtls_padsize.h"
> > > -#include "../cygwin/gcc_seh.h"
> > > +#include "../../cygwin/include/sys/strace.h"
> > > +#include "../../cygwin/include/sys/cygwin.h"
> > > +#include "../../cygwin/include/cygwin/version.h"
> > > +#include "../../cygwin/cygtls_padsize.h"
> > > +#include "../../cygwin/gcc_seh.h"
> > 
> > What about adding -I../../cygwin -I../../cygwin/include to the build
> > rules and get rid of the relative paths inside the sources?
> 
> That seems fraught as it allows cygwin system headers to be picked up in
> preference to mingw ones?
> 
> Using '-idirafter' gets you a build, but it would be much more work to check
> that you've actually built what you wanted to...

Well, ok.  It just looks *so* ugly...  What about at least

  --idirafter ../../cygwin

and then

      #include "include/sys/strace.h"
      #include "include/sys/cygwin.h"
      #include "include/cygwin/version.h"
      #include "cygtls_padsize.h"
      #include "gcc_seh.h"
  
That would disallow picking up system headers and still be a bit
cleaner, no?


Corinna
