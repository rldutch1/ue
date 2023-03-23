ue

UltraEdit Stuff

Control + Spacebar:
Control + Spacebar will show the templates if you type enough of the characters in the name of the template. This is necessary if you have multiple template that start with the same characters but they are in different environments. UltraEdit does not know which environment to display the template so it does not display anything until you press Control + Spacebar and you will see templates from all environments. This topic is at the 09:00 minute mark of this video (https://www.ultraedit.com/support/tutorials-power-tips/ultraedit/smart-templates.html).

Corrupted templates:
I edited the UETMPLTE.TPL file using UES and modified the ("&#xD;" with the carriage return) at the end of each line. In some cases, I had to remove two and a carriage return, or three and a carriage return and replace them with one less than what I was removing.

	For example:
		Replace &#xD;&#xD;<carriage return> with &#xD;<carriage return>
		Replace &#xD;&#xD;&#xD;<carriage return> with &#xD;&#xD;<carriage return>


