Return-Path: <cygwin-patches-return-3332-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16955 invoked by alias); 16 Dec 2002 18:25:35 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 16861 invoked from network); 16 Dec 2002 18:25:34 -0000
Message-ID: <3DFE1AD7.76CA224D@ieee.org>
Date: Mon, 16 Dec 2002 10:25:00 -0000
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: security.cc and sec_acl.cc (ntsec, inheritance and sec_acl)
References: <3.0.5.32.20021205222631.007d3920@mail.attbi.com> <20021210112403.B7796@cygbert.vinschen.de> <3DFDF1C4.575D6360@ieee.org> <20021216184320.H19104@cygbert.vinschen.de> <3DFE151D.B657F3EF@ieee.org> <3DFE1867.1242AEFC@ieee.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q4/txt/msg00283.txt.bz2

> "Pierre A. Humblet" wrote:
> 
> > But frankly I don't understand why it happens!
> 
> OK, I do now. The code is looking forward to entries that
> are not yet processed.

... and thus it may merge entries for the current owner and
for the default owner (creator_owner). Ditto for groups.
That's not good, I need to take care of these special cases.

Pierre
