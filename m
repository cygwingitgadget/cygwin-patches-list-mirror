Return-Path: <cygwin-patches-return-4573-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8638 invoked by alias); 12 Feb 2004 20:50:30 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8622 invoked from network); 12 Feb 2004 20:50:29 -0000
Message-ID: <402BE1BC.3050509@gmx.net>
Date: Thu, 12 Feb 2004 20:50:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Thread safe stdio
References: <4029FF39.9080806@gmx.net> <20040211150103.GA15035@redhat.com>
In-Reply-To: <20040211150103.GA15035@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2004-q1/txt/msg00063.txt.bz2

Christopher Faylor wrote:
> On Wed, Feb 11, 2004 at 11:08:57AM +0100, Thomas Pfaff wrote:
> 
>>The __sinit call must be done after malloc is initialized, otherwise the 
>>mutex creation will fail.
> 
> 
> I am not comfortable with this part of the patch.  I moved the __sinit
> call where I did for a reason.  It needed to be called earlier in the
> process.  I'm also somewhat uncomfortable with using malloc for this
> purpose in general.  It seems like a heavyweight solution to something
> that could be solved with either a muto or a critical section.
> 
> 

Please keep in mind that:

- There does not exist only one mutex, every file has its own that is 
created on fopen and destroyed when it is closed.

- I do not call malloc directly, it is called as part of the mutex creation.

- Every mutex that is associated with an open file must be fork save, it 
has to be recreated after a fork.

- _flock_t can not be a CRITICAL_SECTION nor class muto. You can not 
implement newlibs _LOCK_INIT macro with this types, i have not seen 
something like a CRITICAL_SECTION_INITIALIZER or a MUTO_INITIALIZER.
