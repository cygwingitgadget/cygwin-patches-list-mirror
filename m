Return-Path: <cygwin-patches-return-1531-listarch-cygwin-patches=sourceware.cygnus.com@sources.redhat.com>
Received: (qmail 15552 invoked by alias); 27 Nov 2001 18:58:53 -0000
Mailing-List: contact cygwin-patches-help@sourceware.cygnus.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@sources.redhat.com>
List-Post: <mailto:cygwin-patches@sources.redhat.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@sources.redhat.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@sources.redhat.com
Received: (qmail 15537 invoked from network); 27 Nov 2001 18:58:53 -0000
From: "Gary R Van Sickle" <tiberius@braemarinc.com>
To: <cygwin-patches@cygwin.com>
Subject: RE: [PATCH] setup.exe: Stop NetIO_HTTP from treating entire stream as a  header
Date: Sun, 21 Oct 2001 10:14:00 -0000
Message-ID: <000701c17775$6a1fea40$2101a8c0@d8rc020b>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
In-Reply-To: <20011127184223.GA24028@redhat.com>
X-SW-Source: 2001-q4/txt/msg00063.txt.bz2

> >Ah, better yet.  Jeez you guys are clever ;-).  But how
> about we make it:
> >
> >	while (((l = s->gets ()) != 0) && (*l != '\0'))
> >
> >in the interest of making it a bit more self-documenting?
>
> Actually, how about not using != 0.  Use NULL in this context.
>

Also better yet.

> I don't think that *l is hard to understand, fwiw.
>

Right, it isn't.  I did need to do a double-take though at this ungodly hour
of the afternoon, whereas the '\0' would have reduced that to a single-take
;-).

--
Gary R. Van Sickle
Braemar Inc.
11481 Rupp Dr.
Burnsville, MN 55337
