Return-Path: <cygwin-patches-return-3000-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 18652 invoked by alias); 19 Sep 2002 04:20:12 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18620 invoked from network); 19 Sep 2002 04:20:12 -0000
Date: Wed, 18 Sep 2002 21:20:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: More changes about open on Win95 directories.
Message-ID: <20020919042042.GA13648@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20020918220225.00810100@mail.attbi.com> <3.0.5.32.20020918220225.00810100@mail.attbi.com> <3.0.5.32.20020919001051.008234e0@h00207811519c.ne.client2.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20020919001051.008234e0@h00207811519c.ne.client2.attbi.com>
User-Agent: Mutt/1.4i
X-SW-Source: 2002-q3/txt/msg00448.txt.bz2

On Thu, Sep 19, 2002 at 12:10:51AM -0400, Pierre A. Humblet wrote:
>>>And yesterday's question: On line 173 of fhandler_disk_file.cc 
>>>[strpbrk (get_win32_name (), "?*|<>|")] is there a need for the 
>>>two '|'? Was something else meant?
>>
>>I removed it.  I don't know if there is another invalid character that
>>should go there or not, though.
>
>Is '!' invalid? It can easily be confused with '|'.

'!' seems to be a valid character.

cgf
