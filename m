Return-Path: <cygwin-patches-return-5291-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20650 invoked by alias); 24 Dec 2004 22:16:15 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 20613 invoked from network); 24 Dec 2004 22:16:09 -0000
Received: from unknown (HELO rproxy.gmail.com) (64.233.170.199)
  by sourceware.org with SMTP; 24 Dec 2004 22:16:09 -0000
Received: by rproxy.gmail.com with SMTP id f1so72625rne
        for <cygwin-patches@cygwin.com>; Fri, 24 Dec 2004 14:16:09 -0800 (PST)
Received: by 10.38.67.64 with SMTP id p64mr44061rna;
        Fri, 24 Dec 2004 14:16:09 -0800 (PST)
Received: by 10.38.76.4 with HTTP; Fri, 24 Dec 2004 14:16:08 -0800 (PST)
Message-ID: <cb51e2e041224141679497c00@mail.gmail.com>
Date: Fri, 24 Dec 2004 22:16:00 -0000
From: Joshua Daniel Franklin <joshuadfranklin@gmail.com>
Reply-To: Joshua Daniel Franklin <joshuadfranklin@gmail.com>
To: cygwin-patches@cygwin.com
Subject: keep Cygwin docs well-formed and valid
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-SW-Source: 2004-q4/txt/msg00292.txt.bz2

I just did a commit that touched a lot of sgml files. Now both the
User's Guide (cygwin-ug-net.sgml) and API Reference (cygwin-api.sgml)
are well-formed and valid DocBook XML. The current SGML tools still
work fine with it, but I hope to move the doc Makefile to xmlto soon
to end the confusion with different SGML toolchains (as far as I know
xmlto is standard across platforms, and it's already packaged for
Cygwin).

For anyone who edits the documentation, though, please keep the files
well-formed and valid! This means:

--All tags should be in lower case (like <orderedlist>, not <oRdErEdLiSt)
--If you open a <para>, close it with </para>
--Use entities for 8-bit characters, like &copy; for =A9 and &reg; for =AE.
--Close empty tags, though note that <xref> is weirdly NOT empty but
should be used like this: <xref linkend=3D"cygpath"></xref>
--Always put tag attributes in quotes

Thanks.
