Return-Path: <cygwin-patches-return-1810-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 26472 invoked by alias); 29 Jan 2002 04:14:37 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 26457 invoked from network); 29 Jan 2002 04:14:36 -0000
Date: Mon, 28 Jan 2002 20:14:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH]Reduce messages in setup.log
Message-ID: <20020129041443.GA456@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <000a01c1a879$90fddcf0$0d00a8c0@mchasecompaq>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000a01c1a879$90fddcf0$0d00a8c0@mchasecompaq>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q1/txt/msg00167.txt.bz2

On Mon, Jan 28, 2002 at 08:00:36PM -0800, Michael A Chase wrote:
>A     2 io_stream_file.cc-patch       [applica/octet-stre, quoted, 0.4K]
>A     3 archive.cc-patch              [applica/octet-stre, quoted, 1.5K]
>A     4 compress.cc-patch             [applica/octet-stre, quoted, 1.3K]
>A     5 compress_bz.cc-patch          [applica/octet-stre, quoted, 1.3K]
>A     6 compress_gz.cc-patch          [applica/octet-stre, quoted, 1.4K]
>A     7 io_stream.cc-patch            [applica/octet-stre, quoted, 0.7K]
>A     8 io_stream_cygfile.cc-patch    [applica/octet-stre, quoted, 0.5K]

I don't know how Robert prefers this, but it is customary to provide a
single patch file not a bunch of separate attachments.  With one patch
file you can just say

  patch < foo

rather than

  patch < foo1
  patch < foo2
  patch < foo3
  etc.

cgf
