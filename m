Return-Path: <cygwin-patches-return-4181-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23364 invoked by alias); 8 Sep 2003 21:54:32 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23351 invoked from network); 8 Sep 2003 21:54:31 -0000
Date: Mon, 08 Sep 2003 21:54:00 -0000
Message-Id: <20030909.005423.49835862.radu@primIT.ro>
To: cygwin-patches@cygwin.com
Cc: cgf@redhat.com
Subject: Re: fix getpwuid_r() and getpwnam_r()
From: Radu Greab <rgreab@fx.ro>
In-Reply-To: <20030908214458.GA10128@redhat.com>
References: <20030909.003617.40718540.radu@primIT.ro>
	<20030908214458.GA10128@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-RAVMilter-Version: 8.4.4(snapshot 20030410) (teddy.ms.fx.ro)
X-SW-Source: 2003-q3/txt/msg00197.txt.bz2

Christopher Faylor wrote:
> Actually, I think the fix is more obvious that yours since pw_comment isn't
> used.

I'm just a monkey which thought that pw_comment is used.

> I think yours would result in a SEGV.

Yes, but the SEGV would have been seen in cygwin, not in perl :)


Thanks,
Radu Greab
