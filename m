Return-Path: <cygwin-patches-return-1506-listarch-cygwin-patches=sourceware.cygnus.com@sources.redhat.com>
Received: (qmail 19803 invoked by alias); 19 Nov 2001 18:36:36 -0000
Mailing-List: contact cygwin-patches-help@sourceware.cygnus.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@sources.redhat.com>
List-Post: <mailto:cygwin-patches@sources.redhat.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@sources.redhat.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@sources.redhat.com
Received: (qmail 19789 invoked from network); 19 Nov 2001 18:36:35 -0000
Date: Sun, 14 Oct 2001 08:47:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: Mark Bradshaw <bradshaw@staff.crosswalk.com>
Cc: cygwin-patches@cygwin.com
Subject: Re: patch to mkpasswd.c - allows selection of specific user
Message-ID: <20011119183643.GA1373@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Mark Bradshaw <bradshaw@staff.crosswalk.com>,
	cygwin-patches@cygwin.com
References: <911C684A29ACD311921800508B7293BA010A900F@cnmail>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <911C684A29ACD311921800508B7293BA010A900F@cnmail>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2001-q4/txt/msg00038.txt.bz2

Mark,
We have your assignment on file.

Could you resubmit this patch?

Thanks,
cgf

On Tue, Nov 13, 2001 at 08:09:10AM -0500, Mark Bradshaw wrote:
>Sorry.  I threw that in at the last.  Thought it might be helpful for the
>enduser to get a little feedback for that error.  I'll fix it.
>
>> -----Original Message-----
>> From: Christopher Faylor [mailto:cgf@redhat.com] 
>> Sent: Tuesday, November 13, 2001 12:22 AM
>> To: cygwin-patches@cygwin.com
>> Subject: Re: patch to mkpasswd.c - allows selection of specific user
>> 
>> 
>> On Tue, Nov 13, 2001 at 04:02:32PM +1100, Mathew Boorman wrote:
>> >Darn, now I'm told about Marks patch!
>> >Anyway, onward...
>> >
>> >Mark Bradshaw:
>> >
>> >>@@ -135,6 +145,7 @@ enum_users (LPWSTR servername, int print
>> >> 	default:
>> >> 	  fprintf (stderr, "NetUserEnum() failed with %ld\n", rc);
>> >>+	  if ( rc == 2221 ) printf("That user doesn't appear to 
>> exist.\n");
>> >
>> >The appropriate error codes are in <lmerr.h> around, I noted 
>> some were 
>> >slightly different in name though. I believe this message 
>> should go to 
>> >stderr anyway, otherwise you would end up with a polluted 
>> /etc/passwd 
>> >file.
>> 
>> Oops.  This points out a couple of problems that I didn't 
>> notice before.
>> 
>> 1) Never use a raw number like the above, as Mathew has said.
>> 
>> 2) This is not the correct format for an if statement.  You 
>> aren't adhering
>>    to the GNU formatting conventions.  Please use the 
>> formatting of the
>>    code that you are patching.  This is good advice for 
>> whatever project
>>    you are on.
>> 
>> Thanks,
>> cgf
>> 

-- 
cgf@redhat.com                        Red Hat, Inc.
http://sources.redhat.com/            http://www.redhat.com/
