Return-Path: <cygwin-patches-return-4390-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11313 invoked by alias); 14 Nov 2003 22:18:01 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11262 invoked from network); 14 Nov 2003 22:17:59 -0000
Message-ID: <3FB554AD.2090309@cygwin.com>
Date: Fri, 14 Nov 2003 22:18:00 -0000
From: Robert Collins <rbcollins@cygwin.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5b) Gecko/20030723 Thunderbird/0.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: Re: For masochists: the leap o faith
References: <3FB4D81C.6010808@cygwin.com> <3FB53BAE.3000803@cygwin.com> <20031114220708.GA26100@redhat.com>
In-Reply-To: <20031114220708.GA26100@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2003-q4/txt/msg00109.txt.bz2

Christopher Faylor wrote:

> On Sat, Nov 15, 2003 at 07:31:42AM +1100, Robert Collins wrote:
> 
>>I posted a test case to the developers list when we where working on -O3 
>>support ?two? years back - it looks like the same issue.
> 
> 
> This problem is fixed in the gcc cvs trunk.  I've asked Danny and Gerrit
> about backporting the fix to 3.3.2.  It should be trivial to do so.

In fact, the test case I created "back then" passes now. It may be a 
variant on a theme though.

> 
>>So, Chris, are there any parts you've seen so far, that you've be happy 
>>to ok (i.e. the MAX_PATH->CYG_MAX_PATH rename), or the global search and 
>>replaces to the thunk functions?
> 
> 
> I haven't looked at anything in great detail.  This is not the best
> possible time for me to be reviewing massive changes to cygwin,
> unfortunately.

Ah. Well while there are a lot of textual changes, there are only a few 
logical changes. I'm happy to throw this into a branch and let you 
ponder - but I only have a few hours to actually work on it.

>>As far as applications maing assumptions, unix file systems don't 
>>guarantee PATH_MAX: thats an upper limit of the OS, applications are 
>>expected to be able to handle to up to PATH_MAX... but can't expect the 
>>OS to do so in every case.
> 
> 
> It is fairly unusual for PATH_MAX to be many times greater than what
> is support by pathconf.
> 
> 
>>Now, for global use of an A or W function, Chris' utf patch which I just 
>>ran into digging into a INVALID_NAME error, also chose at runtime. I can 
>>easily alter IOThunkState to always use W if available, and then check a 
>>cached flag from then on in. I really think that the current overhead 
>>will be low enough to be a non-issue though.
> 
> 
> Sorry but you've lost me.  I don't know what my utf patch is.

Chris January :}.

> For the record, I don't have any problems with changing PATH_MAX to
> CYG_PATH_MAX as a first step for this change.  Small steps are, as
> always, appreciated.

Alrighty, will commit that in a minute.

Rob



