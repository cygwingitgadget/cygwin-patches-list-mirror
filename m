Return-Path: <cygwin-patches-return-8055-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24743 invoked by alias); 27 Jan 2015 14:57:38 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 24729 invoked by uid 89); 27 Jan 2015 14:57:36 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=1.9 required=5.0 tests=AWL,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2
X-HELO: vms173011pub.verizon.net
Received: from vms173011pub.verizon.net (HELO vms173011pub.verizon.net) (206.46.173.11) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-SHA encrypted) ESMTPS; Tue, 27 Jan 2015 14:57:35 +0000
Received: from pool-108-7-11-152.bstnma.east.verizon.net ([108.7.11.152]) by vms173011.mailsrvcs.net (Oracle Communications Messaging Server 7.0.5.32.0 64bit (built Jul 16 2014)) with ESMTPSA id <0NIU00LKAC74HR00@vms173011.mailsrvcs.net> for cygwin-patches@cygwin.com; Tue, 27 Jan 2015 08:57:05 -0600 (CST)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.1 cv=Ko/6AtSI c=1 sm=1 tr=0	a=qu2GBZ4KwuZJuA9HnZzXhA==:117 a=kj9zAlcOel0A:10 a=4RoUMAPcAAAA:8	a=o1OHuDzbAAAA:8 a=oR5dmqMzAAAA:8 a=YNv0rlydsVwA:10	a=OfGeiVX-f5fMLafmHr4A:9 a=CjuIK1q_8ugA:10
Message-id: <0NIU00LKBC75HR00@vms173011.mailsrvcs.net>
Date: Tue, 27 Jan 2015 14:57:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <phumblet@phumblet.no-ip.org>
Subject: Re: [PATCH] Add-on to gethostbyname2
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
X-IsSubscribed: yes
X-SW-Source: 2015-q1/txt/msg00010.txt.bz2


>-----Original Message-----
>From: Pierre A Humblet
>Sent: Friday, January 23, 2015 9:30 AM
>
> > From: Corinna Vinschen
> > Sent: Friday, January 23, 2015 5:48 AM
> >
> > On Jan 22 21:05, Pierre A. Humblet wrote:
> > > Add-on to gethostbyname2, as discussed previously on main list.
> > > The diff is also attached.
> > >
> >
> > Do you have some wording for the release info in the docs, please?
> >
>Make gethostbyname2 handle numerical host addresses as well as the 
>reserved domain names "localhost" and "invalid".

Actually it should be "numeric host addresses"

Pierre
