" ####### ----- BASIC Config ----- #######

unmap <Space>
set clipboard=unnamed
imap jj <Esc>
noremap j jzz
noremap k kzz
noremap { {zz
noremap } }zz
nmap H ^
nmap L $



" ####### ----- Clearing Highlights ----- #######

exmap clearNotices obcommand obsidian-smarter-md-hotkeys:hide-notice
nmap &c& :clearNotices
nmap &n& :nohl
nmap <Esc> &c&&n&


" ####### ----- Search and Replace ----- #######

exmap searchReplace obcommand editor:open-search-replace
exmap search obcommand editor:open-search

nmap <Space>fr :searchReplace
nmap <Space>ff :search

 
" ####### ----- Templater ----- #######
exmap templateInsert obcommand templater-obsidian:insert-templater
exmap templateCreate obcommand templater-obsidian:create-new-note-from-template
exmap templateReplace obcommand templater-obsidian:replace-in-file-templater

nmap ti :templateInsert
nmap tc :templateCreate
nmap tr :templateReplace


" ####### ----- Daily-Notes ----- #######
exmap dailyNote obcommand daily-notes
nmap ,d :dailyNote
