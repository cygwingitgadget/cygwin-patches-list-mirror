Return-Path: <cygwin-patches-return-4805-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18824 invoked by alias); 2 Jun 2004 21:17:55 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18814 invoked from network); 2 Jun 2004 21:17:53 -0000
Message-ID: <40BE43B4.4010103@att.net>
Date: Wed, 02 Jun 2004 21:17:00 -0000
From: David Fritz <zeroxdf@att.net>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: Re: [Patch]: NUL and other special names
References: <3.0.5.32.20040531184611.0080be60@incoming.verizon.net> <20040601191818.GA30350@coe.casa.cgf.cx> <40BCFF2B.D4FCDF5@phumblet.no-ip.org> <20040601222846.GA19390@coe.casa.cgf.cx>
In-Reply-To: <20040601222846.GA19390@coe.casa.cgf.cx>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2004-q2/txt/msg00157.txt.bz2

Christopher Faylor wrote:
> On Tue, Jun 01, 2004 at 06:11:55PM -0400, Pierre A. Humblet wrote:
> 
>>Christopher Faylor wrote:
>>
>>>On Mon, May 31, 2004 at 06:46:11PM -0400, Pierre A. Humblet wrote:
>>>
>>>>This patch prevents NtCreateFile from creating files with special
>>>>names such as NUL.
>>>>Because this needs to be checked very often, I tried to code it
>>>>efficiently with a binary search (it can perhaps be reused elsewhere).
>>>>
>>>>The new function is_special_name() overlaps with special_name(),
>>>>although there are small differences (it was designed from tests
>>>>on XP Home Ed). Perhaps these two can be merged one day.
>>>
>>>Haven't we already done a "GetFileAttributes" on the path by the time
>>>it reaches the NtCreateFile?  If so, couldn't we just avoid trying to
>>>create a file which has "bad" attributes?
>>
>>Chris,
>>
>>Yes, we have done a "GetFileAttributes". I just checked the values. 
>>For AUX, CON, COMx, LPTx, NUL and PRN, the attribute is 0x20,
>>FILE_ATTRIBUTE_ARCHIVE 
>>For conin$, conout$ and clock$ it is FFFFFFFF
>>So we could filter on those values and only test for special names
>>if necessary.
>>Is that what you meant?
> 
> 
> I was hoping there might be more state available than that.  Oh well.
> Is the GetFileType call any better?
> 
> I keep thinking that there is a layer of translation that we're missing
> here and we should be somehow using an enumeration that the OS provides
> rather than coming up with our own table.
> 
> cgf
> 

NtQueryAttributesFile() ??
