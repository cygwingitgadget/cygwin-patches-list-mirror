Return-Path: <cygwin-patches-return-4391-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29462 invoked by alias); 14 Nov 2003 22:48:29 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 29233 invoked from network); 14 Nov 2003 22:48:27 -0000
Message-ID: <3FB55BCE.8030304@cygwin.com>
Date: Fri, 14 Nov 2003 22:48:00 -0000
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
X-SW-Source: 2003-q4/txt/msg00110.txt.bz2

Christopher Faylor wrote:

> On Sat, Nov 15, 2003 at 07:31:42AM +1100, Robert Collins wrote:
> 
>>Robert Collins wrote:
>>
>>
>>>Ok, so this it for tonight, my bed is calling me.
>>>

>>As far as applications maing assumptions, unix file systems don't 
>>guarantee PATH_MAX: thats an upper limit of the OS, applications are 
>>expected to be able to handle to up to PATH_MAX... but can't expect the 
>>OS to do so in every case.
> 
> 
> It is fairly unusual for PATH_MAX to be many times greater than what
> is support by pathconf.


And yet: http://www.opengroup.org/onlinepubs/007908799/xsh/fpathconf.html

the notes allude to the issue: unless you call [f]pathconf with a path 
for details on, some implementations won't supply valid information.

You're right though, that we need to update [f]pathconf as part of this.

"
If the implementation needs to use path to determine the value of name 
and the implementation does not support the association of name with the 
file specified by path, or if the process did not have appropriate 
privileges to query the file specified by path, or path does not exist, 
pathconf() returns -1 and errno is set to indicate the error.
"

and in http://www.opengroup.org/onlinepubs/007908799/xsh/limits.h.html
we have " Pathname Variable Values

The values in the following list may be constants within an 
implementation or may vary from one pathname to another. For example, 
file systems or directories may have different characteristics.

A definition of one of the values will be omitted from the <limits.h> 
header on specific implementations where the corresponding value is 
equal to or greater than the stated minimum, but where the value can 
vary depending on the file to which it is applied. The actual value 
supported for a specific pathname will be provided by the pathconf() 
function. "

I think we need to remove the PATH_MAX constant as per their comment, as 
we will now offer runtime differences:
win9X
NT FAT
NT NTFS.

NAME_MAX will still be constant, (although I haven't reviewed msdn on 
that yet).

Rob
