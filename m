Return-Path: <yselkowitz@cygwin.com>
Received: from us-smtp-delivery-44.mimecast.com
 (us-smtp-delivery-44.mimecast.com [205.139.111.44])
 by sourceware.org (Postfix) with ESMTP id A54533858026
 for <cygwin-patches@cygwin.com>; Wed,  2 Dec 2020 18:33:09 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org A54533858026
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-dITLXdtjPyiXtzrHHu3-mQ-1; Wed, 02 Dec 2020 13:33:06 -0500
X-MC-Unique: dITLXdtjPyiXtzrHHu3-mQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6ACB11081B23
 for <cygwin-patches@cygwin.com>; Wed,  2 Dec 2020 18:33:05 +0000 (UTC)
Received: from ovpn-66-71.rdu2.redhat.com (unknown [10.10.67.71])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1DA9B60C17
 for <cygwin-patches@cygwin.com>; Wed,  2 Dec 2020 18:33:04 +0000 (UTC)
Message-ID: <42d8f1f139939b45fef85d00c3e368cf2500b603.camel@cygwin.com>
Subject: Re: [PATCH] Use automake (v3)
From: Yaakov Selkowitz <yselkowitz@cygwin.com>
To: Cygwin Patches <cygwin-patches@cygwin.com>
Date: Wed, 02 Dec 2020 13:33:03 -0500
In-Reply-To: <161bd779-bd17-1e98-5644-bea42c3206cf@dronecode.org.uk>
References: <20201124133720.45823-1-jon.turney@dronecode.org.uk>
 <20201130102524.GC303847@calimero.vinschen.de>
 <20201130104718.GD303847@calimero.vinschen.de>
 <6fa43a94-c29d-fa48-07d0-1ef095d9f5e3@dronecode.org.uk>
 <20201201091833.GJ303847@calimero.vinschen.de>
 <b8610713-5e7d-7b19-93f1-3ded9ca12bc6@dronecode.org.uk>
 <20201202170526.GW303847@calimero.vinschen.de>
 <161bd779-bd17-1e98-5644-bea42c3206cf@dronecode.org.uk>
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: cygwin.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00, JMQ_SPF_NEUTRAL,
 KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE, SPF_HELO_NONE,
 SPF_NEUTRAL, TXREP autolearn=no autolearn_force=no version=3.4.2
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
X-List-Received-Date: Wed, 02 Dec 2020 18:33:10 -0000

On Wed, 2020-12-02 at 18:03 +0000, Jon Turney wrote:
> On 02/12/2020 17:05, Corinna Vinschen via Cygwin-patches wrote:
> > On Dec  2 15:36, Jon Turney wrote:
> > > On 01/12/2020 09:18, Corinna Vinschen wrote:
> > > > What bugs me is that the mingw executables are built in
> > > > utils/mingw,
> > > > but the object files are still in utils.  Any problem
> > > > generating the
> > > > object files in utils/mingw, too?
> > >=20
> > > Not easily.
> > >=20
> > > This behaviour can be turned off by not using the 'subdir-
> > > objects' automake
> > > option.
> > >=20
> > > But then automake warns that option is disabled (since it's going
> > > to be the
> > > default in future).
> >=20
> > So why not just move the mingw source files to utils/mingw, too?
>=20
> There's probably some scope for doing that, but not in all cases, as=20
> some files are built multiple times with different compilers and/or
> flags.
>=20
> e.g. path.cc is built with a cygwin compiler and -DFSTAB as part of=20
> mount, with a MinGW compiler as part of cygcheck, and with a MinGW=20
> compiler and -DTESTSUITE as part of path-testsuite.

Then something like:

$ cat > winsup/utils/mingw/path.cc <<_EOF
#define MINGW // whatever is needed here...
#include "../path.cc"
_EOF

??

--=20
Yaakov

