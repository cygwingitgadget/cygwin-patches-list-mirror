Return-Path: <yselkowitz@cygwin.com>
Received: from us-smtp-delivery-44.mimecast.com
 (us-smtp-delivery-44.mimecast.com [205.139.111.44])
 by sourceware.org (Postfix) with ESMTP id E6C8B3858025
 for <cygwin-patches@cygwin.com>; Wed, 26 May 2021 17:04:57 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org E6C8B3858025
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=yselkowitz@cygwin.com
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-540-1l37A99AO52PKq4A7qsgOw-1; Wed, 26 May 2021 13:04:55 -0400
X-MC-Unique: 1l37A99AO52PKq4A7qsgOw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C87449F92A
 for <cygwin-patches@cygwin.com>; Wed, 26 May 2021 17:04:54 +0000 (UTC)
Received: from yselkowitz.remote.redhat.com (ovpn-118-191.rdu2.redhat.com
 [10.10.118.191])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7D0EE5C238
 for <cygwin-patches@cygwin.com>; Wed, 26 May 2021 17:04:54 +0000 (UTC)
Message-ID: <b3286aea4562bbd9b705060b44892c8fbc3e4a2c.camel@cygwin.com>
Subject: Re: [PATCH] Ensure PSAPI_VERSION is 1 when building ldd
From: Yaakov Selkowitz <yselkowitz@cygwin.com>
To: Cygwin Patches <cygwin-patches@cygwin.com>
Date: Wed, 26 May 2021 13:04:53 -0400
In-Reply-To: <104966fe-2e78-c28f-dcbe-53af7221f117@dronecode.org.uk>
References: <20210520174635.24163-1-jon.turney@dronecode.org.uk>
 <YKalBKpjhBx6mZBg@calimero.vinschen.de>
 <2c57cf3a-ed8f-f3e8-d3bc-a4c5dbe8edaf@dronecode.org.uk>
 <0d7d66f2-48f6-684d-946a-f05d07b329c3@dronecode.org.uk>
 <YK4PIlepWXUOiCHb@calimero.vinschen.de>
 <104966fe-2e78-c28f-dcbe-53af7221f117@dronecode.org.uk>
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: cygwin.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00, JMQ_SPF_NEUTRAL,
 KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_LOW, SPF_HELO_NONE,
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
X-List-Received-Date: Wed, 26 May 2021 17:04:59 -0000

On Wed, 2021-05-26 at 17:51 +0100, Jon Turney wrote:
> On 26/05/2021 10:04, Corinna Vinschen wrote:
> > On May 25 22:37, Jon Turney wrote:
> > > On 22/05/2021 16:08, Jon Turney wrote:
> > > > On 20/05/2021 19:05, Corinna Vinschen wrote:
> > > > > Hi Jon,
> > > > >=20
> > > > > On May 20 18:46, Jon Turney wrote:
> > > > > > The default PSAPI_VERSION is controlled by WIN32_WINNT, which w=
e
> > > > > > set to
> > > > > > 0x0a00 when building ldd, which gets PSAPI_VERSION=3D2.
> > >=20
> > > In the just released w32api 9.0.0, _WIN32_WINNT is now set to 0xa00 b=
y
> > > default, so this issue is probably going to surface in a few other
> > > places as
> > > well.
> >=20
> > I added _WIN32_WINNT and NTDDI_VERSION settings to make sure we notice
> > any problems right away.
>=20
> I'm not sure what the mechanism by which we're going to notice is?
>=20
> Adding WIN32_WINNT=3D0x0a00 everywhere changes the meaning of '#include=
=20
> <psapi.h>' in a way that is incompatible with Vista.
>=20
> So this has broken dumper, and possibly other utils, on Vista.
>=20
> I don't know if there are any other imports in other header which also=20
> have this annoying behaviour...

Does Vista REALLY still need to be supported at this point?

--=20
Yaakov

