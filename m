Return-Path: <cygwin-patches-return-2425-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 7404 invoked by alias); 14 Jun 2002 01:39:51 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7364 invoked from network); 14 Jun 2002 01:39:50 -0000
Message-ID: <088201c21344$9a0d9340$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: <cygwin-patches@cygwin.com>
References: <3.0.5.32.20020613205857.0080d800@mail.attbi.com>
Subject: Re: Reorganizing internal_getlogin() -- modified Pierre patch
Date: Thu, 13 Jun 2002 18:39:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q2/txt/msg00408.txt.bz2

"Pierre A. Humblet" <Pierre.Humblet@ieee.org> wrote:
> I also tried to build the current cvs but get an error
> In file included from ../../../../src/winsup/cygwin/assert.cc:13:
> /src/winsup/w32api/include/wingdi.h:2521: `HENMETAFILE' was not declared
in
> this scope

I just stumbled over that one: it's a typo: should be HENHMETAFILE -- spot
the extra hidden H.

// Conrad


