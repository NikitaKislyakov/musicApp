//
//  ViewController.swift
//  musicApp
//
//  Created by Никита Кисляков on 31.01.2024.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var table: UITableView?
    
    var songs = [Song]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        table?.dataSource = self
        table?.delegate = self
        configureSongs()
    }
    
    func configureSongs() {
        songs.append(Song(name: "Прыгну со скалы",
                          albumName: "Акустический альбом",
                          artistName: "Король и шут",
                          imageName: "cover1",
                          trackName: "kish"))
        songs.append(Song(name: "Silhouette",
                          albumName: "Hattori",
                          artistName: "Miyagi & Эндшпиль",
                          imageName: "cover2",
                          trackName: "miyagi"))
        songs.append(Song(name: "Кофе мой друг",
                          albumName: "Всё, что вокруг",
                          artistName: "Невры",
                          imageName: "cover3",
                          trackName: "nervy"))
        songs.append(Song(name: "Прыгну со скалы",
                          albumName: "Акустический альбом",
                          artistName: "Король и шут",
                          imageName: "cover1",
                          trackName: "kish"))
        songs.append(Song(name: "Silhouette",
                          albumName: "Hattori",
                          artistName: "Miyagi & Эндшпиль",
                          imageName: "cover2",
                          trackName: "miyagi"))
        songs.append(Song(name: "Кофе мой друг",
                          albumName: "Всё, что вокруг",
                          artistName: "Невры",
                          imageName: "cover3",
                          trackName: "nervy"))
        songs.append(Song(name: "Прыгну со скалы",
                          albumName: "Акустический альбом",
                          artistName: "Король и шут",
                          imageName: "cover1",
                          trackName: "kish"))
        songs.append(Song(name: "Silhouette",
                          albumName: "Hattori",
                          artistName: "Miyagi & Эндшпиль",
                          imageName: "cover2",
                          trackName: "miyagi"))
        songs.append(Song(name: "Кофе мой друг",
                          albumName: "Всё, что вокруг",
                          artistName: "Невры",
                          imageName: "cover3",
                          trackName: "nervy"))
    }

}






extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let position = indexPath.row
        
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "player") as? PlayerViewController else { return }

        vc.arrayOfSongs = songs
        vc.position = position
        
        present(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let song = songs[indexPath.row]
        
        cell.textLabel?.text = song.name
        cell.detailTextLabel?.text = song.albumName
        cell.accessoryType = .disclosureIndicator
        cell.imageView?.image = UIImage(named: song.imageName)
        cell.textLabel?.font = UIFont(name: "Helvetica-bold", size: 18)
        cell.detailTextLabel?.font = UIFont(name: "Helvetica", size: 17)
        return cell
    }
    
}

struct Song {
    let name: String
    let albumName: String
    let artistName: String
    let imageName: String
    let trackName: String
}

