Return-Path: <cygwin-patches-return-1823-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 29014 invoked by alias); 29 Jan 2002 09:34:35 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 29000 invoked from network); 29 Jan 2002 09:34:35 -0000
Message-ID: <078d01c1a8a8$2e25b600$0200a8c0@lifelesswks>
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Michael A Chase" <mchase@ix.netcom.com>,
	<cygwin-patches@cygwin.com>
References: <00c601c1a87f$a49a4090$0d00a8c0@mchasecompaq> <049701c1a881$399ea3b0$0200a8c0@lifelesswks> <015501c1a885$7aa4c520$0d00a8c0@mchasecompaq> <061001c1a887$1e5a4bd0$0200a8c0@lifelesswks> <01c101c1a88a$ba3763f0$0d00a8c0@mchasecompaq> <066601c1a88c$43ae51b0$0200a8c0@lifelesswks> <022301c1a898$077666e0$0d00a8c0@mchasecompaq>
Subject: Re: [PATCH]Reduce messages in setup.log (Revision 1)
Date: Tue, 29 Jan 2002 01:34:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 29 Jan 2002 09:34:33.0956 (UTC) FILETIME=[2909BA40:01C1A8A8]
X-SW-Source: 2002-q1/txt/msg00180.txt.bz2

Thanks Michael,
    I'll apply this - minues the io_stream::~io_stream change (I prefer
the current wording because someone could override the destructor, but
not set the flag, thus strictly speaking it only _appears_ that they
haven't.).

Rob
===
----- Original Message -----
From: "Michael A Chase" <mchase@ix.netcom.com>
To: <cygwin-patches@cygwin.com>
Sent: Tuesday, January 29, 2002 6:35 PM
Subject: [PATCH]Reduce messages in setup.log (Revision 1)


> I think this covers the changes we discussed.
> --
> Mac :})
> ** I normally forward private questions to the appropriate mail list.
**
> Ask Smarter: http://www.tuxedo.org/~esr/faqs/smart-questions.htm
> Give a hobbit a fish and he eats fish for a day.
> Give a hobbit a ring and he eats fish for an age.
>
> 2002-01-28  Michael A Chase <mchase@ix.netcom.com>
>
>     * compress_bz.cc (compress_bz::peek): Remove log() call.
>     (compress_bz::~compress_bz): Ditto.
>     (compress_bz::seek): Only write log() message to setup.log.full.
>     * compress_gz.cc (compress_gz::peek): Remove log() call.
>     (compress_gz::error): Ditto.
>     (compress_gz::~compress_gz): Ditto.
>     (compress_gz::seek): Only write log() message to setup.log.full.
>     * io_stream_cygfile.cc (io_stream_cygfile::peek): Remove log()
call.
>     * io_stream_file.cc: Remove #include "log.h".
>     (io_stream_file::peek): Remove log() call.
>     * io_stream.cc (io_stream::factory): Shortened log() message.
>     (io_stream::~io_stream): Shortened log() message.
>
>
