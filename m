Return-Path: <cygwin-patches-return-4370-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30890 invoked by alias); 14 Nov 2003 11:46:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30877 invoked from network); 14 Nov 2003 11:46:06 -0000
Message-ID: <041701c3aaa4$db725ed0$78d96f83@starfruit>
From: "Max Bowsher" <maxb@ukf.net>
To: <cygwin-patches@cygwin.com>
References: <3FB4A341.5070101@cygwin.com> <20031114101815.GU18706@cygbert.vinschen.de> <3FB4AE07.6010101@cygwin.com>
Subject: Re: thunk createDirectory and createFile calls
Date: Fri, 14 Nov 2003 11:46:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
X-SW-Source: 2003-q4/txt/msg00089.txt.bz2

Robert Collins wrote:
> Corinna Vinschen wrote:
> 
>> On Fri, Nov 14, 2003 at 08:41:21PM +1100, Robert Collins wrote:
>> 
>>> inline
>>> BOOL cygwin_create_directory (LPCTSTR filename,
>>> LPSECURITY_ATTRIBUTES sec_attr) {
>>>  return CreateDirectory(filename, sec_attr);
>> 
>>            ^^^^^^^^^^^^^^^
>>    CreateDirectoryA?
> 
> Ah, yeh.

Also, I think LPCTSTR should be LPCSTR ? (and also in the CreateFile case)

Max.
