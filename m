Return-Path: <cygwin-patches-return-2228-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 3501 invoked by alias); 27 May 2002 02:23:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 3460 invoked from network); 27 May 2002 02:23:43 -0000
Date: Sun, 26 May 2002 19:23:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] improve performance of stat() operations (e.g. ls -lR )
Message-ID: <20020527022339.GA15585@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <FE045D4D9F7AED4CBFF1B3B813C85337676295@mail.sandvine.com> <20020527011013.GA15710@redhat.com> <024701c2051d$e13cbdc0$6132bc3e@BABEL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <024701c2051d$e13cbdc0$6132bc3e@BABEL>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q2/txt/msg00212.txt.bz2

On Mon, May 27, 2002 at 02:29:00AM +0100, Conrad Scott wrote:
>"Christopher Faylor" <cgf@redhat.com> wrote:
>>Hmm.  Interesting.  It seems like -E and -X should just be defaulting
>>to doing query_open.  I think that the only reason that query_open is
>>not the default is that the file has to be opened for reading if the
>>executable state is not known.
>>
>>Or, maybe it's actually possible not to do an open at all in those
>>cases.
>>
>>Hmm, again.
>
>A (possibly related) note, it occurred to me the other day (as I looked
>at some strace output) that opening the file during stat() --- so that
>you can call GetFileInformationByHandle() --- will be slow if you've
>got an anti-virus program running since they tend to intercept file
>opens.  Then again, I don't understand enough about cygwin *or* win32
>to understand whether you can get the same information without opening
>the file.  Thus it might be a win to avoid opening the file if possible
>on ntsf too (w/ ntsec).

Yeah, that's why I was thinking that an open wasn't necessary.
Unfortunately, it seems like it is.

You can get nearly all of the information that you need from
FindFirstFile.  Unfortunately, GetFileInformationByHandle() seems to be
the only available function which returns the hard link count of a file.

cgf
