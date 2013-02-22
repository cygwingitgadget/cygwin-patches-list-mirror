Return-Path: <cygwin-patches-return-7838-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2875 invoked by alias); 22 Feb 2013 15:43:55 -0000
Received: (qmail 2864 invoked by uid 22791); 22 Feb 2013 15:43:54 -0000
X-SWARE-Spam-Status: No, hits=-2.8 required=5.0	tests=AWL,BAYES_00,KHOP_RCVD_UNTRUST,KHOP_THREADED,RCVD_IN_DNSWL_LOW,RP_MATCHES_RCVD,SPF_NEUTRAL,TW_SF
X-Spam-Check-By: sourceware.org
Received: from bureau58.ns.utoronto.ca (HELO bureau58.ns.utoronto.ca) (128.100.132.145)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 22 Feb 2013 15:43:45 +0000
Received: from [192.168.0.100] (69-165-162-170.dsl.teksavvy.com [69.165.162.170])	(authenticated bits=0)	by bureau58.ns.utoronto.ca (8.13.8/8.13.8) with ESMTP id r1MFhfFI001508	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)	for <cygwin-patches@cygwin.com>; Fri, 22 Feb 2013 10:43:43 -0500
Message-ID: <51279232.6080006@cs.utoronto.ca>
Date: Fri, 22 Feb 2013 15:43:00 -0000
From: Ryan Johnson <ryan.johnson@cs.utoronto.ca>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 64bit] Export <io.h> symbols with underscore
References: <20130221111545.GA24054@calimero.vinschen.de> <20130221194236.GA1163@ednor.casa.cgf.cx> <20130222001848.7049805a@YAAKOV04> <20130222065110.GA7834@ednor.casa.cgf.cx> <20130222080025.GI28458@calimero.vinschen.de> <20130222084951.GJ28458@calimero.vinschen.de> <20130222034047.778e1e12@YAAKOV04> <20130222095128.GF21700@calimero.vinschen.de> <20130222100255.GA32597@calimero.vinschen.de> <20130222143206.GC8104@ednor.casa.cgf.cx> <20130222144448.GD22106@calimero.vinschen.de>
In-Reply-To: <20130222144448.GD22106@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2013-q1/txt/msg00049.txt.bz2

On 22/02/2013 9:44 AM, Corinna Vinschen wrote:
> On Feb 22 09:32, Christopher Faylor wrote:
>> On Fri, Feb 22, 2013 at 11:02:55AM +0100, Corinna Vinschen wrote:
>>> On Feb 22 10:51, Corinna Vinschen wrote:
>>>> On Feb 22 03:40, Yaakov wrote:
>>>>> On Fri, 22 Feb 2013 09:49:51 +0100, Corinna Vinschen wrote:
>>>>>>> access should go, no doubt about it.
>>>>>>>
>>>>>>> For get_osfhandle and setmode I would prefer maintaining backward
>>>>>>> compatibility with existing applications.  Both variations, with and
>>>>>>> without underscore are definitely in use.
>>>>>>>
>>>>>>> What about exporting the underscored variants only, but define the
>>>>>>> non-underscored ones:
>>>>>>>
>>>>>>>    extern long _get_osfhandle(int);
>>>>>>>    #define get_osfhandle(i) _get_osfhandle(i)
>>>>>>>
>>>>>>>    extern int _setmode (int __fd, int __mode);
>>>>>>>    #define setmode(f,m) _setmode((f),(m))
>>>>>> Just to be clear:  On 32 bit we should keep the exported symbols, too.
>>>>>> On 64 bit we can drop the non-underscored ones (which just requires
>>>>>> to rebuild gawk for me) and only keep the defines for backward
>>>>>> compatibility.
>>>>> Like this?
>>>> Almost.  The _setmode needs a tweak, too.  I also think it makes
>>>> sense to rename the functions inside of syscalls.cc:
>>>> [...]
>>> I applied this patch to the 64 bit branch for now.
>> I was actually expecting that we'd break the compilation of existing
>> applications which incorrectly referenced get_osfhandle and setmode (I
>> have a couple of those).  It's a simple fix if someone recompiles and
>> it wouldn't be the first time that you'd have to make a source code
>> change when upreving to a new "OS".  For 32-bit we would need to keep
>> both in cygwin.din though, of course.
> I'm trying to keep up with backward compatibility on the source level
> as far as it makes sense (for a given value of "sense").
>
>> But, if you're going to use defines, why not just simplify them as:
>>
>> #define get_osfhandle _get_osfhandle
>> #define setmode _setmode
> I can do that, but I thought error messages would be more meaningful
> when using macros with arguments.  Dunno, I was just trying to do
> it right.  Shall I still simplify them?
The advantage of going function-form on the macro is that the 
preprocessor is smart enough to leave non-function uses of the 
identifier untouched:

#define foo(x,y) bar(x,y)
...
foo(1, 2); // changed to bar(1,2)
int foo = 10; // left as `foo'

That might matter, e.g. if somebody had a class with a member function 
that used both _setmode (a private class member) and setmode (a local 
variable). Or if that member function were itself called setmode.

On the other hand, the error messages might be slightly more useful with 
an identifier-form macro, depending on what you prefer to see:

#define foo hi
#define bar(x,y) hi(x,y)
int hi(int,int);
...
foo(1); // error: too few arguments to function âint hi(int, int)â
              // note: declared here [pointer to the declaration of hi()]
bar(1); // error: macro "bar" requires 2 arguments, but only 1 given

Overall, I favor using function-form macros in this sort of situation, 
because I'd rather not risk surprise changes to identifiers (and the 
macro argument error isn't confusing, just not as complete as the 
function version, because cpp doesn't point you to the offending macro's 
definition).

$0.02
Ryan
