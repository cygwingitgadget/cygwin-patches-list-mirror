Return-Path: <cygwin-patches-return-8053-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15155 invoked by alias); 23 Jan 2015 14:30:55 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 15065 invoked by uid 89); 23 Jan 2015 14:30:48 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2
X-HELO: vms173021pub.verizon.net
Received: from vms173021pub.verizon.net (HELO vms173021pub.verizon.net) (206.46.173.21) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-SHA encrypted) ESMTPS; Fri, 23 Jan 2015 14:30:38 +0000
Received: from PHumbletLap01 ([50.200.185.42]) by vms173021.mailsrvcs.net (Oracle Communications Messaging Server 7.0.5.32.0 64bit (built Jul 16 2014)) with ESMTPA id <0NIM004FJWAHONA0@vms173021.mailsrvcs.net> for cygwin-patches@cygwin.com; Fri, 23 Jan 2015 08:30:18 -0600 (CST)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.1 cv=LrklEcZZ c=1 sm=1 tr=0	a=++QE0vWJ+/OcbE0B+pKMCw==:117 a=YJNfha0CqZgA:10 a=IkcTkHD0fZMA:10	a=4RoUMAPcAAAA:8 a=oR5dmqMzAAAA:8 a=-9mUelKeXuEA:10 a=YNv0rlydsVwA:10	a=XoMuhdoLKi3_1UF-HoAA:9 a=QEXdDO2ut3YA:10 a=xWXhc56Es3UA:10	a=qsHoVo9qmXoA:10 a=oiWx-9KKH28A:10
From: <phumblet@phumblet.no-ip.org>
To: <cygwin-patches@cygwin.com>
References: <0NIL00E86XTQH2L1@vms173013.mailsrvcs.net> <20150123104758.GB5612@calimero.vinschen.de>
In-reply-to: <20150123104758.GB5612@calimero.vinschen.de>
Subject: RE: [PATCH] Add-on to gethostbyname2
Date: Fri, 23 Jan 2015 14:30:00 -0000
Message-id: <010c01d03719$1c312fc0$54938f40$@phumblet.no-ip.org>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
Content-transfer-encoding: quoted-printable
X-IsSubscribed: yes
X-SW-Source: 2015-q1/txt/msg00008.txt.bz2

> From: Corinna Vinschen
> Sent: Friday, January 23, 2015 5:48 AM
>=20=09
> On Jan 22 21:05, Pierre A. Humblet wrote:
> > Add-on to gethostbyname2, as discussed previously on main list.
> > The diff is also attached.
> >
>=20
> Do you have some wording for the release info in the docs, please?
>=20
Make gethostbyname2 handle numerical host addresses as well as the reserved=
 domain names "localhost" and "invalid".

Pierre

