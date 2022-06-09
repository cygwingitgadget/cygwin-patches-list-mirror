Return-Path: <yselkowitz@cygwin.com>
Received: from us-smtp-delivery-44.mimecast.com
 (us-smtp-delivery-44.mimecast.com [207.211.30.44])
 by sourceware.org (Postfix) with ESMTPS id EEB4F3850850
 for <cygwin-patches@cygwin.com>; Thu,  9 Jun 2022 16:00:42 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org EEB4F3850850
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-625-yPHGfQiwPJidxnwtSRKVSg-1; Thu, 09 Jun 2022 12:00:38 -0400
X-MC-Unique: yPHGfQiwPJidxnwtSRKVSg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 37A15101E986
 for <cygwin-patches@cygwin.com>; Thu,  9 Jun 2022 16:00:38 +0000 (UTC)
Received: from yselkowitz.remote.redhat.com (unknown [10.22.35.48])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 14A901410DDB
 for <cygwin-patches@cygwin.com>; Thu,  9 Jun 2022 16:00:38 +0000 (UTC)
Message-ID: <d4c98759c0e3d7fcc72e13566d7c00d71a52bb52.camel@cygwin.com>
Subject: Re: [PATCH 7/7] Cygwin: remove miscellaneous 32-bit code
From: Yaakov Selkowitz <yselkowitz@cygwin.com>
To: cygwin-patches@cygwin.com
Date: Thu, 09 Jun 2022 12:00:37 -0400
In-Reply-To: <YqIQX4HJ8lXveQdx@calimero.vinschen.de>
References: <2de3539b-efc2-b6f1-b9e3-8429ecb24c0b@cornell.edu>
 <ce7de251-14d1-e54d-e2ef-5b67ad256a64@dronecode.org.uk>
 <c5bec956-6e71-083e-f3bf-f6b52726b218@cornell.edu>
 <YqIQX4HJ8lXveQdx@calimero.vinschen.de>
User-Agent: Evolution 3.42.4 (3.42.4-2.module_f35+14217+587aad52)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: cygwin.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00, BODY_8BITS,
 KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_LOW, SPF_FAIL, SPF_HELO_NONE,
 TXREP, T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
X-List-Received-Date: Thu, 09 Jun 2022 16:00:44 -0000

On Thu, 2022-06-09 at 17:23 +0200, Corinna Vinschen wrote:
> On May 29 17:26, Ken Brown wrote:
> > On 5/29/2022 9:39 AM, Jon Turney wrote:
> > > On 26/05/2022 20:17, Ken Brown wrote:
> > > > =C2=A0 winsup/cygwin/autoload.cc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 136 -----------=
----------
> > > > --
> > >=20
> > > Looks good.
> > >=20
> > > I think that perhaps the stdcall decoration number n is unused on
> > > x86_64, so can be removed also in a followup?
> >=20
> > Thanks, I missed that.
> >=20
> > Also, I guess most or all of the uses of __stdcall and __cdecl can be
> > removed from the code.
>=20
> Yes, that's right, given there's only one calling convention on 64 bit.
>=20
> I have a minor objection in terms of this patch.
>=20
> When implementing support for AMD64, there were basically 2 problems to
> solve. One of them was to support 64 bit systems, the other one was to
> support AMD64.=C2=A0 At that time, only IA-64 and AMD64 64 bit systems
> existed, and since we never considered IA-64 to run Cygwin on, we
> subsumed all 64 bit code paths under the __x86_64__ macro.
>=20
> But should we *ever* support ARM64, as unlikely as it is, we have to
> make sure to find all the places where the code is specificially AMD64.
> That goes, for instance, for all places calling assembler code, or
> for exception handling accessing CPU registers, etc.
>=20
> I'm open to discussion, but I think the code being CPU-specific
> should still be enclosed into #ifdef __x86_64__ brackets, with an
> #else #error alternative.
>=20
> Right?=C2=A0 Wrong?=C2=A0 Useless complication?

Highly recommended.

--=20
Yaakov

